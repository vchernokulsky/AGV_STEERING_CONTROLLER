//
// Created by data-scientist on 18.08.2020.
//

#ifndef AGV_REMOTECONTROL_VELOCITYPUBLISHER_H
#define AGV_REMOTECONTROL_VELOCITYPUBLISHER_H

#include "VehicleController.h"
#include <geometry_msgs/Twist.h>
#include "ros.h"

class VelocityPublisher {
    VehicleController vehicleController;
    ros::Publisher publisher;
    geometry_msgs::Twist twist;

public:
    VelocityPublisher();
    esp_err_t init(ros::NodeHandle *nodeHandle);
    void publish(void);
};


#endif //AGV_REMOTECONTROL_VELOCITYPUBLISHER_H
