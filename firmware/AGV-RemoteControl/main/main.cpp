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

static void tcpClientTask(void *arg) {
    TcpClient *tcpClient = (TcpClient *) arg;
    tcpClient->tcpClientLoop();
}

static void tcpSendTask(void *arg) {
    TcpClient *tcpClient = (TcpClient *) arg;
    static char s[] = "Aloha!";
    while(1) {
        tcpClient->sock_send(s, strlen(s));
        vTaskDelay(100);
    }
}

static void tcpRecvTask(void *arg) {
    TcpClient *tcpClient = (TcpClient *) arg;
    static char s[1024];
    static uint32_t remain;
    while(1) {
        tcpClient->sock_recv(&s[0], 1024, &remain);
        std::cout << "Recv | " << s << std::endl;
        std::fill(s, s + 1024, '\0');
        vTaskDelay(100);
    }
}

extern "C" void app_main()
{
    TcpClient tcpClient;

    esp_ros_wifi_init();

    tcpClient.init(3331, "192.168.35.135", 3000);

    xTaskCreatePinnedToCore(tcpClientTask, "TcpClientTask", 1024, (void*) &tcpClient, 1, NULL, 0);
    xTaskCreatePinnedToCore(tcpSendTask, "TcpSendTask", 1024, (void*) &tcpClient, 1, NULL, 0);
    xTaskCreatePinnedToCore(tcpRecvTask, "TcpRecvTask", 1024, (void*) &tcpClient, 1, NULL, 0);
}
