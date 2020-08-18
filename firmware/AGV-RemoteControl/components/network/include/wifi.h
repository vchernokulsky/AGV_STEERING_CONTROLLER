//
// Created by data-scientist on 12.08.2020.
//

#ifndef AGV_REMOTECONTROL_WIFI_H
#define AGV_REMOTECONTROL_WIFI_H

#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/event_groups.h"
#include "esp_system.h"
#include "esp_wifi.h"
#include "esp_event_loop.h"
#include "nvs_flash.h"
#include "sdkconfig.h"


#define MAXIMUM_RETRY  5

#define ROS_SERVER_AP CONFIG_ROSSERVER_AP
#define ROS_SERVER_PASS CONFIG_ROSSERVER_PASS

void esp_ros_wifi_init(void);
#endif //AGV_REMOTECONTROL_WIFI_H
