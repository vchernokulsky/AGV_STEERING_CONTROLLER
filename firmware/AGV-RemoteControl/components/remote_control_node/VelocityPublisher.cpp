//
// Created by data-scientist on 18.08.2020.
//

#include "include/VelocityPublisher.h"

VelocityPublisher::VelocityPublisher(): publisher("/cmd_vel", &twist) {

}

esp_err_t VelocityPublisher::init(ros::NodeHandle *nodeHandle) {
    if (vehicleController.init() != ESP_OK) {
        return ESP_FAIL;
    }
    nodeHandle->advertise(publisher);
    return ESP_OK;
}
void VelocityPublisher::publish() {
    twist.linear.x = 1;
    twist.linear.y = 2;
    twist.linear.z = 3;

    twist.angular.x = 4;
    twist.angular.y = 5;
    twist.angular.z = 6;

    publisher.publish(&twist);
}