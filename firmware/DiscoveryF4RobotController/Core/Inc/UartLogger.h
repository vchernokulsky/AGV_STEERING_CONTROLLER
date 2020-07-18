/*
 * UartLogger.h
 *
 *  Created on: Jul 8, 2020
 *      Author: data-scientist
 */

#ifndef INC_UARTLOGGER_H_
#define INC_UARTLOGGER_H_

#include <string.h>
#include <stdio.h>
#include "stm32f4xx_hal.h"
#include "lwip/netif.h"

#include "mainpp.h"
#include "BuildInformation.h"
#include "SetUpHelper.h"

#define FLOAT_DEFAULT_PRECISION 5

class UartLogger {
	UART_HandleTypeDef *huart;

	const char *vendorMsg = "Vendor: IntemsLab";

	// Network headers
	const char *macHeader = "MAC address: ";
	const char *localIpHeader = "Local IP: ";
	const char *networkMaskHeader = "Network mask: ";
	const char *gatewayHeader = "Gateway: ";
	const char *dhcpHeader = "Using DHCP: ";
	const char *networkInterfaceHeader = "Network interface: ";
	const char *CableHeader = "Cable: ";

	// ROS headers
	const char *wheelRadiusHeader = "Wheel radius: ";
	const char *wheelSeparationHeader = "Wheel separation: ";
	const char *maxLinSpeedHeader = "Max linear speed: ";
	const char *maxAngVelHeader = "Max angular velocity: ";
	const char *maxPwdAllowedHeader = "Max PWD allowed: ";
	const char *radPerTickHeader = "Radius per tick: ";

	const char *cmdVelHeader = "CMD_VEL topic name: ";
	const char *odomTopicdHeader = "Odometry topic name: ";
	const char *baseFramedHeader = "Base frame: ";
	const char *odomFramedHeader = "Odometry frame: ";

public:
	UartLogger();
	virtual ~UartLogger();

	void setUart(UART_HandleTypeDef *huart);
	void log(const char *str);
	void logNewLine();
	void logAddress(uint8_t* addr); // IP, gateway, network mask
	void logDhcp(bool use_dhcp);
	void logMac(uint8_t *hwaddr);
	void logCableState(enum CableState cableState);
	void logNetworkInterfaceState(struct netif *gnetif);
	void logInt(int val);
	void logFloat(float val, int precision = FLOAT_DEFAULT_PRECISION);

	void logStartup(SetUpHelper *main_settings, struct netif *gnetif,  enum CableState cableState);

	void logBuildInformation(void);
	void logVendor(void);
	void logEeprom(SetUpHelper *main_settings);
	void logNetwork(SetUpHelper *main_settings, struct netif *gnetif, enum CableState cableState);
	void logRos(SetUpHelper *main_settings);

};

#endif /* INC_UARTLOGGER_H_ */
