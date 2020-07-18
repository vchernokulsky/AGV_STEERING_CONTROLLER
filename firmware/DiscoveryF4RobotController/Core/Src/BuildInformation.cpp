/*
 * BuildInformation.cpp
 *
 *  Created on: 14 июл. 2020 г.
 *      Author: derzh
 */
#include "BuildInformation.h"

namespace build_info {
	const char buildInfo[] = BUILD_INFORMATION;
	const char firmware_version_str[] = FIRMWARE_VERSION_STR;
	const uint8_t firmware_version_str_len = strlen(firmware_version_str);
	const char firmware_version_buf[] = FIRMWARE_VERSION_BUF;
}


