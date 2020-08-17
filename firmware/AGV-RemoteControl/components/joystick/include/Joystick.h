//
// Created by data-scientist on 15.08.2020.
//

#ifndef AGV_REMOTECONTROL_JOYSTICK_H
#define AGV_REMOTECONTROL_JOYSTICK_H

#include "driver/gpio.h"
#include "driver/adc.h"
#include "esp_adc_cal.h"

#define NO_OF_SAMPLES   64

class Joystick {

public:
    Joystick();
    virtual ~Joystick();

    void init();
};


#endif //AGV_REMOTECONTROL_JOYSTICK_H
