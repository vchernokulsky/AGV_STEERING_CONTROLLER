//
// Created by data-scientist on 18.08.2020.
//

#ifndef AGV_REMOTECONTROL_REMOTECONTROL_H
#define AGV_REMOTECONTROL_REMOTECONTROL_H

#include "VelocityPublisher.h"
#include "ros.h"

class RemoteController {
    ros::NodeHandle nodeHandle;
    VelocityPublisher velocityPublisher;

public:
    RemoteController();
    esp_err_t init(TcpClient *tcpClient);
    void doRemoteControlTask();
};


#endif //AGV_REMOTECONTROL_REMOTECONTROL_H
