/*
 * SettingsResponseBuilder.cpp
 *
 *  Created on: 13 июл. 2020 г.
 *      Author: derzh
 */

#include <SetUpHelperResponseBuilder.h>

SetUpHelperResponseBuilder::SetUpHelperResponseBuilder() {
	// TODO Auto-generated constructor stub

}

SetUpHelperResponseBuilder::~SetUpHelperResponseBuilder() {
	// TODO Auto-generated destructor stub
}

void SetUpHelperResponseBuilder::build_response(uint8_t *response, uint16_t *response_len, uint8_t *settings_mem, uint16_t settings_mem_len) {
	memcpy(response, settings_mem, settings_mem_len);
	memcpy(response + settings_mem_len, build_info::firmware_version_buf,  FIRMWARE_VERSION_BUF_LEN);

	*response_len = settings_mem_len + FIRMWARE_VERSION_BUF_LEN;
}
