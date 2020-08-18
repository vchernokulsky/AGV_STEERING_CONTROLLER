//
// Created by data-scientist on 12.08.2020.
//

#include "include/wifi.h"

static EventGroupHandle_t wifi_event_group;

const int IPV4_GOTIP_BIT = BIT0;

static const char *TAG = "esp-ros-wifi";

static int s_retry_num = 0;

static esp_err_t event_handler(void *ctx, system_event_t *event)
{
    switch(event->event_id) {
        case SYSTEM_EVENT_STA_START:
            esp_wifi_connect();
            break;
        case SYSTEM_EVENT_STA_GOT_IP:
            s_retry_num = 0;
            xEventGroupSetBits(wifi_event_group, IPV4_GOTIP_BIT);
            break;
        case SYSTEM_EVENT_STA_DISCONNECTED:
        {
            if (s_retry_num < MAXIMUM_RETRY) {
                esp_wifi_connect();
                xEventGroupClearBits(wifi_event_group, IPV4_GOTIP_BIT);
                s_retry_num++;
            }
            break;
        }
        default:
            break;
    }
    return ESP_OK;
}

void esp_ros_wifi_init()
{
    nvs_flash_init();

    wifi_event_group = xEventGroupCreate();

    tcpip_adapter_init();
    ESP_ERROR_CHECK(esp_event_loop_init(event_handler, NULL) );

    wifi_init_config_t cfg = WIFI_INIT_CONFIG_DEFAULT();
    ESP_ERROR_CHECK(esp_wifi_init(&cfg));

    wifi_config_t wifi_config = {
            {ROS_SERVER_AP, ROS_SERVER_PASS}
    };

    ESP_ERROR_CHECK(esp_wifi_set_mode(WIFI_MODE_STA) );
    ESP_ERROR_CHECK(esp_wifi_set_config(ESP_IF_WIFI_STA, &wifi_config) );
    ESP_ERROR_CHECK(esp_wifi_start());

    xEventGroupWaitBits(wifi_event_group, IPV4_GOTIP_BIT, false, true, portMAX_DELAY);
}