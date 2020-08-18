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
#define LEFT_WHEEL_ADC_CHANNEL ADC_CHANNEL_0
#define RIGHT_WHEEL_ADC_CHANNEL ADC_CHANNEL_3

#define SPEED_MAX 255 // максимальное абсолютное значение скорости

class VehicleController {
    uint16_t adcMeasurements[2]; // 0 - X, 1 - Y (angle, speed)

public:
    esp_err_t init();
    esp_err_t getSpeed(int *leftWheelSpeed, int *rightWheelSpeed);
};


#endif //AGV_REMOTECONTROL_JOYSTICK_H
