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
		if (TcpClient::is_connected) {
			velocityPublisher.publish();
			nodeHandle.spinOnce();
		}
		t3 = esp_timer_get_time();
        vTaskDelay(5);
    }
}
