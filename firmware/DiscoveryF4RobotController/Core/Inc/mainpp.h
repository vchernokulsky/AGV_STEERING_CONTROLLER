#ifndef INC_MAINPP_H_
#define INC_MAINPP_H_

#ifdef __cplusplus
 extern "C" {
#endif

#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include "cmsis_os.h"
#include <stdbool.h>

#include "stm32f4xx_hal.h"

void run_app(UART_HandleTypeDef *huart, I2C_HandleTypeDef *main_hi2c1,
		TIM_HandleTypeDef *main_htim,
		TIM_HandleTypeDef *main_htim2,
		TIM_HandleTypeDef *encoder_htim,
		TIM_HandleTypeDef *encoder_htim2);

void memory_setup();
void external_memory_init(I2C_HandleTypeDef *main_hi2c1);
void threds_setup(TIM_HandleTypeDef *main_htim,  TIM_HandleTypeDef *main_htim2, TIM_HandleTypeDef *encoder_htim, TIM_HandleTypeDef *encoder_htim2);
void set_default();

uint8_t* get_local_ip_ptr();
uint8_t* get_network_mask_ptr();
uint8_t* get_gateaway_ptr();
void set_default_network_routing();
void set_network_routing(uint8_t *local_ip, uint8_t *network_mask, uint8_t *gateaway, bool use_dhcp);

void updateCableState(void);

enum CableState {
	cablePluggedIn,
	cablePluggedOff
};

#ifdef __cplusplus
}
#endif


#endif /* INC_MAINPP_H_ */
