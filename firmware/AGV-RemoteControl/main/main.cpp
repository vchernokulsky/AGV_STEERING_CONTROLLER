/* Hello World Example

   This example code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/

#include <iostream>

#include "VehicleController.h"
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
VehicleController vehicleController;

static void rosTask(void *arg) {
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

static void vehicleControlTask(void *arg) {
    static int leftWheelSpeed, rightWheelSpeed;
    while (1) {
        if (vehicleController.getSpeed(&leftWheelSpeed, &rightWheelSpeed) != ESP_OK) {
            std::cout << "ESP_FAIL" << std::endl;
        } else {
            std::cout << leftWheelSpeed << " " << rightWheelSpeed << std::endl;
        }
        vTaskDelay(1000 / portTICK_PERIOD_MS);
    }
}

extern "C" void app_main() {
    esp_ros_wifi_init();

    tcpClient.init(ROSSERVER_IP, ROSSERVER_PORT);
    nh.initNode(&tcpClient);

    if (vehicleController.init() != ESP_OK) {
        std::cout << "ESP_FAIL" << std::endl;
    }
    xTaskCreatePinnedToCore(rosTask, "rosTask", 2048, NULL, 1, NULL, 0);
    xTaskCreatePinnedToCore(tcpClientTask, "tcpClientTask", 1024, NULL, 1, NULL, 0);
    xTaskCreatePinnedToCore(vehicleControlTask, "vehicleControlTask", 4 * 1024, NULL, 1, NULL, 0);
}
