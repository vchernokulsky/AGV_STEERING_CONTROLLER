//
// Created by data-scientist on 15.08.2020.
//
#include <iostream>
#include <cstring>
#include "include/VehicleController.h"

esp_err_t VehicleController::init() {
    static_assert(LEFT_WHEEL_ADC_CHANNEL != RIGHT_WHEEL_ADC_CHANNEL, "X and Y ADC channels must be different");
    adc_channel_t channels[] = {LEFT_WHEEL_ADC_CHANNEL, RIGHT_WHEEL_ADC_CHANNEL};
    if (i2s_adc_setup(I2S_ADC_UNIT, &channels[0], 2, I2S_NUM, CLKM) != ESP_OK) {
        return ESP_FAIL;
    }

    return ESP_OK;
}

esp_err_t VehicleController::getSpeed(int *leftWheelSpeed, int *rightWheelSpeed) {
    if (get_adc(I2S_NUM, &adcMeasurements[0], 4) != ESP_OK) {
        return ESP_FAIL;
    }
    static int leftWheelSpeedVal;
    static int rightWheelSpeedVal;

    if (adcMeasurements[0] >> 12 == (uint16_t) LEFT_WHEEL_ADC_CHANNEL) {
        leftWheelSpeedVal = adcMeasurements[0] & 0xfff;
        rightWheelSpeedVal = adcMeasurements[1] & 0xfff;
    } else {
        leftWheelSpeedVal = adcMeasurements[1] & 0xfff;
        rightWheelSpeedVal = adcMeasurements[0] & 0xfff;
    }
    *leftWheelSpeed = (leftWheelSpeedVal * SPEED_MAX) / 2048 - SPEED_MAX;
    *rightWheelSpeed = (rightWheelSpeedVal * SPEED_MAX) / 2048 - SPEED_MAX;
    memset(adcMeasurements, 0, 4);
    return ESP_OK;
}