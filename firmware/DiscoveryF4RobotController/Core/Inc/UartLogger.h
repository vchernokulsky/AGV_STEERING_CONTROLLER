/*
 * UartLogger.h
 *
 *  Created on: Jul 8, 2020
 *      Author: data-scientist
 */

#ifndef INC_UARTLOGGER_H_
#define INC_UARTLOGGER_H_

#include "BuildInformation.h"

#include <string.h>
#include "stm32f4xx_hal.h"

class UartLogger {
	UART_HandleTypeDef *huart;
	const char *buildInfo = BUILD_INFORMATION;
public:
	UartLogger();

	void setUart(UART_HandleTypeDef *huart);
	void log(const char *str);
	void logBuildInformation(void);

	virtual ~UartLogger();
};

#endif /* INC_UARTLOGGER_H_ */
