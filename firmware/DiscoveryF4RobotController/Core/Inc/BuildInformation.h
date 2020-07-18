/*
 * BuildInformation.h
 *
 *  Created on: Jul 8, 2020
 *      Author: data-scientist
 */

#ifndef INC_BUILDINFORMATION_H_
#define INC_BUILDINFORMATION_H_

#include <string.h>
#include "cmsis_os.h"

#define FIRMWARE_VERSION_STR "v0.0.0"

#define FIRMWARE_VERSION_BUF {0, 0, 0}
#define FIRMWARE_VERSION_BUF_LEN 3

#ifdef DEBUG
	#define BUILD_INFORMATION "Firmware: debug\n"
#else
	#define BUILD_INFORMATION "Firmware: release " FIRMWARE_VERSION_STR "\n"
#endif

namespace build_info {
	extern const char buildInfo[];
	extern const char firmware_version_str[];
	extern const uint8_t firmware_version_str_len;
	extern const char firmware_version_buf[];
}

#endif /* INC_BUILDINFORMATION_H_ */
