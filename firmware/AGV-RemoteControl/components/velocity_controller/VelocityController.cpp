//
// Created by data-scientist on 15.08.2020.
//
#include "include/VelocityController.h"

esp_err_t VelocityController::init() {
    static_assert(LINEAR_ADC_CHANNEL != ANGULAR_ADC_CHANNEL, "linear speed and angular speed ADC channels must be different");

    adc1_config_width(ADC_WIDTH_BIT_12);
    adc1_config_channel_atten(LINEAR_ADC_CHANNEL, ADC_ATTEN_DB_11);
    adc1_config_channel_atten(ANGULAR_ADC_CHANNEL, ADC_ATTEN_DB_11);

    return ESP_OK;
}

esp_err_t VelocityController::getSpeed(double *linearSpeed, double *angularSpeed) {
    *linearSpeed = GET_ADC(LINEAR_ADC_CHANNEL) * LINEAR_SPEED_MAX / 2048 - LINEAR_SPEED_MAX;
    *angularSpeed = (GET_ADC(ANGULAR_ADC_CHANNEL) * ANGULAR_SPEED_MAX / 2048 - ANGULAR_SPEED_MAX);
    return ESP_OK;
}