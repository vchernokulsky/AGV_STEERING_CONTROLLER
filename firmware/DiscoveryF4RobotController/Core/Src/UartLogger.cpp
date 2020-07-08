/*
 * UartLogger.cpp
 *
 *  Created on: Jul 8, 2020
 *      Author: data-scientist
 */

#include <UartLogger.h>

UartLogger::UartLogger() {
	// TODO Auto-generated constructor stub
}

void UartLogger::logBuildInformation(void) {
	log(buildInfo);
}

void UartLogger::log(const char *str) {
	HAL_UART_Transmit(huart,  (uint8_t*) str, strlen(str), 0xFFFF);
}

void UartLogger::setUart(UART_HandleTypeDef *huart) {
	this->huart = huart;
}

UartLogger::~UartLogger() {
	// TODO Auto-generated destructor stub
}
