//
// Created by data-scientist on 15.08.2020.
//

#ifndef AGV_REMOTECONTROL_JOYSTICK_H
#define AGV_REMOTECONTROL_JOYSTICK_H

#include <cmath>

#include "esp_err.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/i2s.h"
#include "driver/adc.h"
#include "driver/ledc.h"
#include "dig_i2s_adc.h"

#define _USE_MATH_DEFINES

#define I2S_NUM I2S_NUM_0
#define I2S_ADC_UNIT ADC_UNIT_1
#define CLKM 50
#define LINEAR_ADC_CHANNEL ADC1_CHANNEL_0
#define ANGULAR_ADC_CHANNEL ADC1_CHANNEL_3

#define LINEAR_SPEED_MAX 100 // максимальное абсолютное значение линейной скорости
#define ANGULAR_SPEED_MAX M_PI_2

#define GET_ADC(channel) adc1_get_raw((adc1_channel_t)channel)
class VelocityController {
public:
    esp_err_t init();
    esp_err_t getSpeed(double * linearSpeed, double *angularSpeed);
};


#endif //AGV_REMOTECONTROL_JOYSTICK_H
