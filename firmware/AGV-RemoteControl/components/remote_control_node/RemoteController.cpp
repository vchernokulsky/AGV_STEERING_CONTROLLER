//
// Created by data-scientist on 18.08.2020.
//

#include "include/RemoteController.h"
#include "TcpClient.h"

#include <iostream>
#include "esp_timer.h"


RemoteController::RemoteController() {

}

esp_err_t RemoteController::init(TcpClient *tcpClient) {
    nodeHandle.initNode(tcpClient);
    if (velocityPublisher.init(&nodeHandle) != ESP_OK) {
        return ESP_FAIL;
    }
    return ESP_OK;
}

void RemoteController::doRemoteControlTask() {
    while(1) {
    	int t3 = 0;
    	int t4 = 0;
        if( xSemaphoreTake( TcpClient::error_semaphore, portMAX_DELAY) == pdTRUE ) {
            if (TcpClient::is_connected) {
                xSemaphoreGive( TcpClient::error_semaphore );
                velocityPublisher.publish();
                vTaskDelay(10);
                t3 = esp_timer_get_time();
                nodeHandle.spinOnce();
                t4 = esp_timer_get_time();
            }
            else {
                xSemaphoreGive( TcpClient::error_semaphore );
            }
        }
		std::cout << "SpinOnce: " << float(t4 - t3) / 1000000.0f << std::endl;
		std::cout << "-----------------------------------" << std::endl;
        vTaskDelay(10);
    }
}
