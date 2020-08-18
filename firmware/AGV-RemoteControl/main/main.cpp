/* Hello World Example

   This example code is in the Public Domain (or CC0 licensed, at your option.)

   Unless required by applicable law or agreed to in writing, this
   software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
   CONDITIONS OF ANY KIND, either express or implied.
*/

#include "RemoteController.h"
#include "TcpClient.h"
#include "wifi.h"

#include "esp_spi_flash.h"
#include <string.h>
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"

#define ROSSERVER_IP CONFIG_ROSSERVER_IP
#define ROSSERVER_PORT CONFIG_ROSSERVER_PORT

TcpClient tcpClient;
RemoteController remoteController;

static void tcpClientTask(void *arg) {
    tcpClient.doTcpClientTask();
}

static void remoteControlTask(void *arg) {
    remoteController.doRemoteControlTask();
}

extern "C" void app_main() {
    esp_ros_wifi_init();

    tcpClient.init(ROSSERVER_IP, ROSSERVER_PORT);
    remoteController.init(&tcpClient);

    xTaskCreatePinnedToCore(tcpClientTask, "tcpClientTask", 1024, NULL, 1, NULL, 0);
    xTaskCreatePinnedToCore(remoteControlTask, "remoteControlTask", 4 * 1024, NULL, 1, NULL, 0);
}
