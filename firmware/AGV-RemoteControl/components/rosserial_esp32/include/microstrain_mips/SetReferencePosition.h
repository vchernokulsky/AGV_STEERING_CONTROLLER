#ifndef _ROS_SERVICE_SetReferencePosition_h
#define _ROS_SERVICE_SetReferencePosition_h
#include <stdint.h>
#include <string.h>
#include <stdlib.h>
#include "ros/msg.h"
#include "geometry_msgs/Vector3.h"

namespace microstrain_mips
{

static const char SETREFERENCEPOSITION[] = "microstrain_mips/SetReferencePosition";

  class SetReferencePositionRequest : public ros::Msg
  {
    public:
      typedef geometry_msgs::Vector3 _position_type;
      _position_type position;

    SetReferencePositionRequest():
      position()
    {
    }

    virtual int serialize(unsigned char *outbuffer) const
    {
      int offset = 0;
      offset += this->position.serialize(outbuffer + offset);
      return offset;
    }

    virtual int deserialize(unsigned char *inbuffer)
    {
      int offset = 0;
      offset += this->position.deserialize(inbuffer + offset);
     return offset;
    }

    const char * getType(){ return SETREFERENCEPOSITION; };
    const char * getMD5(){ return "e7bb0ef028c744b081acdc57743b11d8"; };

  };

  class SetReferencePositionResponse : public ros::Msg
  {
    public:
      typedef bool _success_type;
      _success_type success;

    SetReferencePositionResponse():
      success(0)
    {
    }

    virtual int serialize(unsigned char *outbuffer) const
    {
      int offset = 0;
      union {
        bool real;
        uint8_t base;
      } u_success;
      u_success.real = this->success;
      *(outbuffer + offset + 0) = (u_success.base >> (8 * 0)) & 0xFF;
      offset += sizeof(this->success);
      return offset;
    }

    virtual int deserialize(unsigned char *inbuffer)
    {
      int offset = 0;
      union {
        bool real;
        uint8_t base;
      } u_success;
      u_success.base = 0;
      u_success.base |= ((uint8_t) (*(inbuffer + offset + 0))) << (8 * 0);
      this->success = u_success.real;
      offset += sizeof(this->success);
     return offset;
    }

    const char * getType(){ return SETREFERENCEPOSITION; };
    const char * getMD5(){ return "358e233cde0c8a8bcfea4ce193f8fc15"; };

  };

  class SetReferencePosition {
    public:
    typedef SetReferencePositionRequest Request;
    typedef SetReferencePositionResponse Response;
  };

}
#endif
