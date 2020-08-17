//
// Created by data-scientist on 15.08.2020.
//

#ifndef AGV_REMOTECONTROL_JOYSTICK_H
#define AGV_REMOTECONTROL_JOYSTICK_H

#include "esp_err.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "driver/i2s.h"
#include "driver/adc.h"
#include "driver/ledc.h"
#include "dig_i2s_adc.h"

#define I2S_NUM I2S_NUM_0
#define I2S_ADC_UNIT ADC_UNIT_1
#define CLKM 50
#define X_ADC_CHANNEL ADC_CHANNEL_0
#define Y_ADC_CHANNEL ADC_CHANNEL_3

class VehicleController {
    uint16_t adcMeasurements[2]; // 0 - X, 1 - Y

    esp_err_t getSpeedAndAngle(int *speed, int *wheelAngle);
public:
    esp_err_t init();
};


#endif //AGV_REMOTECONTROL_JOYSTICK_H
