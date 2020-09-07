/*
 * Software License Agreement (BSD License)
 *
 * Copyright (c) 2011, Willow Garage, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above
 *    copyright notice, this list of conditions and the following
 *    disclaimer in the documentation and/or other materials provided
 *    with the distribution.
 *  * Neither the name of Willow Garage, Inc. nor the names of its
 *    contributors may be used to endorse or promote prducts derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#ifndef ROS_NODE_HANDLE_H_
#define ROS_NODE_HANDLE_H_

#include "TcpClient.h"

#include <stdint.h>

#include "std_msgs/Time.h"
#include "rosserial_msgs/TopicInfo.h"
#include "rosserial_msgs/Log.h"
#include "rosserial_msgs/RequestParam.h"

#include "ros/msg.h"


namespace ros {

    class NodeHandleBase_ {
    public:
        virtual int publish(int id, const Msg *msg) = 0;

        virtual int spinOnce() = 0;

        virtual bool connected() = 0;
    };
}

#include "ros/publisher.h"
#include "ros/subscriber.h"
#include "ros/service_server.h"
#include "ros/service_client.h"

namespace ros {

    const int SPIN_OK = 0;
    const int SPIN_ERR = -1;
    const int SPIN_TIMEOUT = -2;

    using rosserial_msgs::TopicInfo;

/* Node Handle */
    template<class Hardware,
            int MAX_SUBSCRIBERS = 25,
            int MAX_PUBLISHERS = 25,
            int INPUT_SIZE = 512,
            int OUTPUT_SIZE = 512>
    class NodeHandle_ : public NodeHandleBase_ {
    protected:
        Hardware hardware_;

        /* used for computing current time */
        uint32_t sec_offset, nsec_offset;

        /* Spinonce maximum work timeout */

        uint8_t message_in[INPUT_SIZE];
        uint8_t message_out[OUTPUT_SIZE];

        Publisher *publishers[MAX_PUBLISHERS];
        Subscriber_ *subscribers[MAX_SUBSCRIBERS];

        /*
         * Setup Functions
         */
    public:
        NodeHandle_() : configured_(false) {

            for (unsigned int i = 0; i < MAX_PUBLISHERS; i++)
                publishers[i] = 0;

            for (unsigned int i = 0; i < MAX_SUBSCRIBERS; i++)
                subscribers[i] = 0;

            for (unsigned int i = 0; i < INPUT_SIZE; i++)
                message_in[i] = 0;

            for (unsigned int i = 0; i < OUTPUT_SIZE; i++)
                message_out[i] = 0;

            req_param_resp.ints_length = 0;
            req_param_resp.ints = NULL;
            req_param_resp.floats_length = 0;
            req_param_resp.floats = NULL;
            req_param_resp.ints_length = 0;
            req_param_resp.ints = NULL;
        }

        Hardware *getHardware() {
            return &hardware_;
        }

        /* Start a named port, which may be network server IP, initialize buffers */
        void initNode(TcpClient *tcpClient) {
            hardware_.init(tcpClient);
            topic_ = 0;
        };


    protected:
        int topic_;
        bool configured_;

        /* used for syncing the time */
        uint32_t last_sync_time;
        uint32_t last_sync_receive_time;
        uint32_t last_msg_timeout_time;

    public:
        /* This function goes in your loop() function, it handles
         *  serial input and callbacks for subscribers.
         */


        virtual int spinOnce() {
// Custom spinOnce
            static uint16_t msg_len;
            static uint16_t topic;

            hardware_.read((uint8_t*) &msg_len, 2);
            hardware_.read((uint8_t*) &topic, 2);
            if (msg_len > INPUT_SIZE || msg_len < 0) {
                return SPIN_ERR;
            }

            hardware_.read((uint8_t*) message_in, msg_len);

//            topic_ = (uint16_t)(message_in[1] << 8) + (uint16_t) message_in[0];
            topic_ = topic;
            if (topic_ == TopicInfo::ID_TIME) {
                syncTime(message_in);
            } else if (topic_ == TopicInfo::ID_PARAMETER_REQUEST) {
                req_param_resp.deserialize(message_in);
                param_recieved = true;
            } else if (topic_ == 0) {
                requestSyncTime();
                negotiateTopics();
                return SPIN_ERR;
            } else if (topic_ == TopicInfo::ID_TX_STOP) {
                configured_ = false;
            } else {
                if (subscribers[topic_ - 100]) {
                    subscribers[topic_ - 100]->callback(message_in + 2); // первые 2 байта - id топика, затем сообщение
                }
            }

            return SPIN_OK;
        }


        /* Are we connected to the PC? */
        virtual bool connected() {
            return configured_;
        };

        /********************************************************************
         * Time functions
         */

        void requestSyncTime() {
            std_msgs::Time t;
            publish(TopicInfo::ID_TIME, &t);
        }

        void syncTime(uint8_t *data) {
            std_msgs::Time t;
            t.deserialize(data);
            this->setNow(t.data);
        }

        Time now() {
            uint32_t ms = hardware_.time();
            Time current_time;
            current_time.sec = ms / 1000 + sec_offset;
            current_time.nsec = (ms % 1000) * 1000000UL + nsec_offset;
            return current_time;
        }

        void setNow(Time &new_now) {
            uint32_t ms = hardware_.time();
            sec_offset = new_now.sec - ms / 1000 - 1;
            nsec_offset = new_now.nsec - (ms % 1000) * 1000000UL + 1000000000UL;
        }

        /********************************************************************
         * Topic Management
         */

        /* Register a new publisher */
        bool advertise(Publisher &p) {
            for (int i = 0; i < MAX_PUBLISHERS; i++) {
                if (publishers[i] == 0) // empty slot
                {
                    publishers[i] = &p;
                    p.id_ = i + 100 + MAX_SUBSCRIBERS;
                    p.nh_ = this;
                    return true;
                }
            }
            return false;
        }

        /* Register a new subscriber */
        template<typename SubscriberT>
        bool subscribe(SubscriberT &s) {
            for (int i = 0; i < MAX_SUBSCRIBERS; i++) {
                if (subscribers[i] == 0) // empty slot
                {
                    subscribers[i] = static_cast<Subscriber_ *>(&s);
                    s.id_ = i + 100;
                    return true;
                }
            }
            return false;
        }

        /* Register a new Service Server */
        template<typename MReq, typename MRes, typename ObjT>
        bool advertiseService(ServiceServer <MReq, MRes, ObjT> &srv) {
            bool v = advertise(srv.pub);
            for (int i = 0; i < MAX_SUBSCRIBERS; i++) {
                if (subscribers[i] == 0) // empty slot
                {
                    subscribers[i] = static_cast<Subscriber_ *>(&srv);
                    srv.id_ = i + 100;
                    return v;
                }
            }
            return false;
        }

        /* Register a new Service Client */
        template<typename MReq, typename MRes>
        bool serviceClient(ServiceClient <MReq, MRes> &srv) {
            bool v = advertise(srv.pub);
            for (int i = 0; i < MAX_SUBSCRIBERS; i++) {
                if (subscribers[i] == 0) // empty slot
                {
                    subscribers[i] = static_cast<Subscriber_ *>(&srv);
                    srv.id_ = i + 100;
                    return v;
                }
            }
            return false;
        }

        void negotiateTopics() {
            rosserial_msgs::TopicInfo ti;
            int i;
            for (i = 0; i < MAX_PUBLISHERS; i++) {
                if (publishers[i] != 0) // non-empty slot
                {
                    ti.topic_id = publishers[i]->id_;
                    ti.topic_name = (char *) publishers[i]->topic_;
                    ti.message_type = (char *) publishers[i]->msg_->getType();
                    ti.buffer_size = OUTPUT_SIZE;
                    publish(publishers[i]->getEndpointType(), &ti);
                }
            }
            for (i = 0; i < MAX_SUBSCRIBERS; i++) {
                if (subscribers[i] != 0) // non-empty slot
                {
                    ti.topic_id = subscribers[i]->id_;
                    ti.topic_name = (char *) subscribers[i]->topic_;
                    ti.message_type = (char *) subscribers[i]->getMsgType();
                    ti.buffer_size = INPUT_SIZE;
                    publish(subscribers[i]->getEndpointType(), &ti);
                }
            }
            configured_ = true;
        }

        virtual int publish(int id, const Msg *msg) {
            if (id >= 100 && !configured_) {
                return 0;
            }

            /* serialize message */
            int l = msg->serialize(message_out + 4);
            message_out[0] = (uint8_t)((uint16_t) l & 255);
            message_out[1] = (uint8_t)((uint16_t) l >> 8);
            message_out[2] = (uint8_t)((int16_t) id & 255);
            message_out[3] = (uint8_t)((int16_t) id >> 8);
            l += 4;
            if (l <= OUTPUT_SIZE) {
                hardware_.write(message_out, l);
                return l;
            } else {
                logerror("Message from device dropped: message larger than buffer.");
                return -1;
            }
        }

        /********************************************************************
         * Logging
         */

    private:
        void log(char byte, const char *msg) {
            rosserial_msgs::Log l;
            l.level = byte;
            l.msg = (char *) msg;
            publish(rosserial_msgs::TopicInfo::ID_LOG, &l);
        }

    public:
        void logdebug(const char *msg) {
            log(rosserial_msgs::Log::ROSDEBUG, msg);
        }

        void loginfo(const char *msg) {
            log(rosserial_msgs::Log::INFO, msg);
        }

        void logwarn(const char *msg) {
            log(rosserial_msgs::Log::WARN, msg);
        }

        void logerror(const char *msg) {
            log(rosserial_msgs::Log::ERROR, msg);
        }

        void logfatal(const char *msg) {
            log(rosserial_msgs::Log::FATAL, msg);
        }

        /********************************************************************
         * Parameters
         */

    private:
        bool param_recieved;
        rosserial_msgs::RequestParamResponse req_param_resp;

        bool requestParam(const char *name, int time_out = 1000) {
            param_recieved = false;
            rosserial_msgs::RequestParamRequest req;
            req.name = (char *) name;
            publish(TopicInfo::ID_PARAMETER_REQUEST, &req);
            uint32_t end_time = hardware_.time() + time_out;
            while (!param_recieved) {
                spinOnce();
                if (hardware_.time() > end_time) {
                    logwarn("Failed to get param: timeout expired");
                    return false;
                }
            }
            return true;
        }

    public:
        bool getParam(const char *name, int *param, int length = 1, int timeout = 1000) {
            if (requestParam(name, timeout)) {
                if (length == req_param_resp.ints_length) {
                    //copy it over
                    for (int i = 0; i < length; i++)
                        param[i] = req_param_resp.ints[i];
                    return true;
                } else {
                    logwarn("Failed to get param: length mismatch");
                }
            }
            return false;
        }

        bool getParam(const char *name, float *param, int length = 1, int timeout = 1000) {
            if (requestParam(name, timeout)) {
                if (length == req_param_resp.floats_length) {
                    //copy it over
                    for (int i = 0; i < length; i++)
                        param[i] = req_param_resp.floats[i];
                    return true;
                } else {
                    logwarn("Failed to get param: length mismatch");
                }
            }
            return false;
        }

        bool getParam(const char *name, char **param, int length = 1, int timeout = 1000) {
            if (requestParam(name, timeout)) {
                if (length == req_param_resp.strings_length) {
                    //copy it over
                    for (int i = 0; i < length; i++)
                        strcpy(param[i], req_param_resp.strings[i]);
                    return true;
                } else {
                    logwarn("Failed to get param: length mismatch");
                }
            }
            return false;
        }
    };

}

#endif
