//
// Created by data-scientist on 15.08.2020.
//

#include "include/VehicleController.h"

esp_err_t VehicleController::init() {
    static_assert(X_ADC_CHANNEL != Y_ADC_CHANNEL, "X and Y ADC channels must be different");
    adc_channel_t channels[] = {X_ADC_CHANNEL, Y_ADC_CHANNEL};
    if (i2s_adc_setup(I2S_ADC_UNIT, &channels[0], 2, I2S_NUM, CLKM) != ESP_OK) {
        return ESP_FAIL;
    }

    return ESP_OK;
}

esp_err_t VehicleController::getSpeedAndAngle(int *speed, int *wheelAngle) {
    if (get_adc(I2S_NUM, &adcMeasurements[0], 4) != ESP_OK) {
        return ESP_FAIL;
    }
    // to be continued ...
    return ESP_OK;
}