/*
 * BuildInformation.h
 *
 *  Created on: Jul 8, 2020
 *      Author: data-scientist
 */

#ifndef INC_BUILDINFORMATION_H_
#define INC_BUILDINFORMATION_H_

#ifdef DEBUG
	#define BUILD_INFORMATION "Firmware: debug\n"
#else
	#define FIRMWARE_VERSION "v0.0.0"
	#define BUILD_INFORMATION "Firmware: release " FIRMWARE_VERSION "\n" \
							  "\0"
#endif



#endif /* INC_BUILDINFORMATION_H_ */
