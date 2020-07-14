/*
 * SettingsResponseBuilder.h
 *
 *  Created on: 13 июл. 2020 г.
 *      Author: derzh
 */

#ifndef INC_SETUPHELPERRESPONSEBUILDER_H_
#define INC_SETUPHELPERRESPONSEBUILDER_H_

#include <string.h>
#include "cmsis_os.h"

#include "BuildInformation.h"
#include "SetUpHelper.h"

class SetUpHelperResponseBuilder {
public:
	SetUpHelperResponseBuilder();
	virtual ~SetUpHelperResponseBuilder();

	static void build_response(uint8_t *response, uint16_t *response_len, uint8_t *settings_mem, uint16_t settings_mem_len);
};

#endif /* INC_SETUPHELPERRESPONSEBUILDER_H_ */
