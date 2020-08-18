//
// Created by data-scientist on 18.08.2020.
//

#include "include/RemoteController.h"
#include "TcpClient.h"

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
        if( xSemaphoreTake( TcpClient::error_semaphore, portMAX_DELAY) == pdTRUE ) {
            if (TcpClient::is_connected) {
                xSemaphoreGive( TcpClient::error_semaphore );
                velocityPublisher.publish();
                nodeHandle.spinOnce();
            }
            else {
                xSemaphoreGive( TcpClient::error_semaphore );
            }
        }

        vTaskDelay(1);
    }
}