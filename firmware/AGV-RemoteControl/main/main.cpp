/* Hello World Example

   This example code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/
#include <iostream>
#include <algorithm>

#include "TcpClient.h"
#include "wifi.h"
#include "esp_spi_flash.h"

#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#include "ros.h"
#include "std_msgs/String.h"

#define ROSSERVER_IP CONFIG_ROSSERVER_IP
#define ROSSERVER_PORT CONFIG_ROSSERVER_PORT

TcpClient tcpClient;
ros::NodeHandle nh;

static void RosTask(void *arg) {
    static std_msgs::String str_msg;
    static ros::Publisher pub("publisher", &str_msg);

    nh.advertise(pub);
    static char msg[] = "Aloha!";

    while(1) {
        str_msg.data = msg;
        pub.publish(&str_msg);
        nh.spinOnce();
        vTaskDelay(1);
    }
}

static void tcpClientTask(void *arg) {
    tcpClient.tcpClientLoop();
}

extern "C" void app_main() {
    tcpClient.init(ROSSERVER_IP, ROSSERVER_PORT);
    nh.initNode(&tcpClient);

    esp_ros_wifi_init();

    xTaskCreatePinnedToCore(RosTask, "RosTask", 2048, NULL, 1, NULL, 0);
    xTaskCreatePinnedToCore(tcpClientTask, "TcpClientTask", 1024, NULL, 1, NULL, 0);
}
