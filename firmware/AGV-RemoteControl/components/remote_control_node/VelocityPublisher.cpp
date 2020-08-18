//
// Created by data-scientist on 18.08.2020.
//

#include "include/VelocityPublisher.h"

VelocityPublisher::VelocityPublisher(): publisher("/cmd_vel", &twist) {

}

esp_err_t VelocityPublisher::init(ros::NodeHandle *nodeHandle) {
    if (velocityController.init() != ESP_OK) {
        return ESP_FAIL;
    }
    nodeHandle->advertise(publisher);
    return ESP_OK;
}
void VelocityPublisher::publish() {
    velocityController.getSpeed(&twist.linear.x, &twist.angular.z);
    publisher.publish(&twist);
}