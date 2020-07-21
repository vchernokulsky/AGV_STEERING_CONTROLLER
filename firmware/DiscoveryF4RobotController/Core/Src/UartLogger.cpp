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
	log(build_info::buildInfo);
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

void UartLogger::logStartup(SetUpHelper *main_settings, struct netif *gnetif, enum CableState cableState) {
	logBuildInformation();
	logNewLine();
	logVendor();
	logNewLine();
	logEeprom(main_settings);
	logNewLine();
	logNetwork(main_settings, gnetif, cableState);
	logNewLine();
	logRos(main_settings);
}

void UartLogger::logEeprom(SetUpHelper *main_settings) {
	log(eepromHeader);
	log(main_settings->status == HAL_OK ? "successfully" : "failed");
}

void UartLogger::logNetwork(SetUpHelper *main_settings, struct netif *gnetif, enum CableState cableState) {
	log(macHeader);
	logMac(gnetif->hwaddr);
	logNewLine();

	log(localIpHeader);
	logAddress(main_settings->LOCAL_IP_ADDRESS);
	logNewLine();

	log(networkMaskHeader);
	logAddress(main_settings->NETWORK_MASK);
	logNewLine();

	log(gatewayHeader);
	logAddress(main_settings->GATEAWAY);
	logNewLine();

	log(dhcpHeader);
	logDhcp(main_settings->USE_DHCP);
	logNewLine();

	log(CableHeader);
	logCableState(cableState);
	logNewLine();

	log(networkInterfaceHeader);
	logNetworkInterfaceState(gnetif);
}

void UartLogger::logVendor(void) {
	log(vendorMsg);
}

void UartLogger::logNewLine() {
	log("\n");
}

void UartLogger::logAddress(uint8_t *addr) {
	char str[12];
	sprintf(str, "%d.%d.%d.%d", addr[0], addr[1], addr[2], addr[3]);
	log(str);
}

void UartLogger::logDhcp(bool use_dhcp) {
	log(use_dhcp ? "true": "false");
}

void UartLogger::logMac(uint8_t *hwaddr) {
	char str[17];
	sprintf(str, "%X.%X.%X.%X.%X.%X", hwaddr[0], hwaddr[1], hwaddr[2], hwaddr[3], hwaddr[4], hwaddr[5]);
	log(str);
}

void UartLogger::logInt(int val) {
	char str[5];
	sprintf(str, "%d", val);
	log(str);
}

void UartLogger::logFloat(float val, int precision) {
	char str[7 + precision];
	int signed_ceil = (int) val;
	float fl = abs(val) - abs(signed_ceil);

	for(int i = 0; !(int)fl && i != precision; ++i) {
		fl *= 10;
	}
	sprintf(str, "%d.%d", signed_ceil, (int) fl);
	log(str);
}

void UartLogger::logCableState(enum CableState cableState) {
	log(cableState == cablePluggedIn ? "plugged in" : "plugged off");
}

void UartLogger::logNetworkInterfaceState(struct netif *gnetif) {
	log(netif_is_link_up(gnetif) ? "link up" : "link down");
}

void UartLogger::logRos(SetUpHelper *main_settings) {
	log(rosClientPortHeader);
	logInt(main_settings->ROS_CLIENT_PORT);
	logNewLine();

	log(setUpServerPortHeader);
	logInt(main_settings->SET_UP_SERVER_PORT);
	logNewLine();

	log(serialNodeIpHeader);
	logAddress(main_settings->SERIALNODE_IP);
	logNewLine();

	log(serialNodePortHeader);
	logInt(main_settings->SERIALNODE_PORT);
	logNewLine();

	log(wheelRadiusHeader);
	logFloat(main_settings->WHEEL_RADIUS);
	logNewLine();

	log(wheelSeparationHeader);
	logFloat(main_settings->WHEEL_SEPARATION);
	logNewLine();

	log(maxLinSpeedHeader);
	logFloat(main_settings->MAX_LIN_SPEED);
	logNewLine();

	log(maxAngVelHeader);
	logFloat(main_settings->MAX_ANG_VEL);
	logNewLine();

	log(maxPwdAllowedHeader);
	logInt((int) main_settings->MAX_PWD_ALLOWED);
	logNewLine();

	log(radPerTickHeader);
	logFloat(main_settings->RAD_PER_TICK);
	logNewLine();

	log(cmdVelHeader);
	log(main_settings->CMD_VEL_TOPIC);
	logNewLine();

	log(odomTopicdHeader);
	log(main_settings->ODOM_TOPIC);
	logNewLine();

	log(baseFramedHeader);
	log(main_settings->BASE_FRAME);
	logNewLine();

	log(odomFramedHeader);
	log(main_settings->ODOM_FRAME);
}
