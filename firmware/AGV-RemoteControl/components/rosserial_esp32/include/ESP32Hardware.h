#ifndef ROS_ESP32_HARDWARE_H_
#define ROS_ESP32_HARDWARE_H_

extern "C" {
#include "sdkconfig.h"
#include "stdio.h"
#include "esp_err.h"
#include "esp_timer.h"
#include <driver/uart.h>
}

#include "TcpClient.h"

class ESP32Hardware
{
    protected:
        uint8_t rx_buf[1024];
        TcpClient *tcpClient;

    public:
        ESP32Hardware()
        {
        }

        // Initialization code for ESP32
        void init(TcpClient *tcpClient)
        {
            this->tcpClient = tcpClient;
        }

        // read a byte from the serial port. -1 = failure
        bool read(uint8_t *buf, uint16_t size)
        {
           return tcpClient->sock_recv_all(buf, size);
        }

        // write data to the connection to ROS
        void write(uint8_t* data, uint16_t length)
        {
            tcpClient->sock_send(data, length);
        }

        // returns milliseconds since start of program
        unsigned long time()
        {
            return esp_timer_get_time() / 1000;
        }
};
#endif
