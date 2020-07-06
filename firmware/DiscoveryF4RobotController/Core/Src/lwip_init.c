/**
 ******************************************************************************
  * File Name          : LWIP.c
  * Description        : This file provides initialization code for LWIP
  *                      middleWare.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under Ultimate Liberty license
  * SLA0044, the "License"; You may not use this file except in compliance with
  * the License. You may obtain a copy of the License at:
  *                             www.st.com/SLA0044
  *
  ******************************************************************************
  */
  
/* Includes ------------------------------------------------------------------*/
#include "lwip_init.h"
#include "lwip/init.h"
#include "lwip/netif.h"
#include "lwip/dhcp.h"

#include <stdbool.h>
#include <string.h>
/* Variables Initialization */
struct netif gnetif;
ip4_addr_t ipaddr;
ip4_addr_t netmask;
ip4_addr_t gw;
uint8_t IP_ADDRESS[4] ;
uint8_t NETMASK_ADDRESS[4];
uint8_t GATEWAY_ADDRESS[4];

// from SetUpHelper.h
extern uint8_t* get_local_ip_ptr();
extern uint8_t* get_network_mask_ptr();
extern uint8_t* get_gateaway_ptr();

// from main.c
extern osTimerId dhcp_setup_timerHandle;

bool dhcp_setup_time_up;
/**
  * LwIP initialization function
  */

void LWIP_Init(bool use_dhcp) {
	if (!use_dhcp) {
		LWIP_Init_static_routing(get_local_ip_ptr(), get_network_mask_ptr(), get_gateaway_ptr());
	}
	else {
		bool success = LWIP_Init_dynamic_routing();

		if (!success) {
			dhcp_release(&gnetif);
			dhcp_stop(&gnetif);
			netif_remove(&gnetif);

			uint8_t ip[] = DEFAULT_ROBOT_IP_ADRESS;
			uint8_t mask[] = DEFAULT_NETWORK_MASK;
			uint8_t gw[] = DEFAULT_GATEAWAY;

			LWIP_Init_static_routing((uint8_t*) ip, (uint8_t*) mask, (uint8_t*) gw);
		}

	}
}
void LWIP_Init_static_routing(uint8_t *local_ip, uint8_t *network_mask, uint8_t *gateaway)
{
	tcpip_init( NULL, NULL );
	setup_static_routing(local_ip, network_mask, gateaway);
	setup_network_interface();
}

bool LWIP_Init_dynamic_routing(void)
{
	tcpip_init( NULL, NULL );
	ipaddr.addr = 0;
	netmask.addr = 0;
	gw.addr = 0;

	setup_network_interface();

	dhcp_setup_time_up = 0;
	dhcp_start(&gnetif);

	osTimerStart(dhcp_setup_timerHandle, DHCP_SETUP_TIMEOUT);

	while(!gnetif.ip_addr.addr && !dhcp_setup_time_up) {
	  osDelay(1);
	}

	if (!dhcp_setup_time_up) {
	  osTimerStop(dhcp_setup_timerHandle);
	  return true;
	}
	return false;
}

void finish_dhcp_setup(void const * argument) {
	dhcp_setup_time_up = 1;
}

void setup_static_routing(uint8_t *local_ip, uint8_t *network_mask, uint8_t *gateaway) {
	  memcpy(IP_ADDRESS, local_ip, IP_SIZE);
	  memcpy(NETMASK_ADDRESS, network_mask, IP_SIZE);
	  memcpy(GATEWAY_ADDRESS, gateaway, IP_SIZE);
	  /* IP addresses initialization without DHCP (IPv4) */
	  IP4_ADDR(&ipaddr, IP_ADDRESS[0], IP_ADDRESS[1], IP_ADDRESS[2], IP_ADDRESS[3]);
	  IP4_ADDR(&netmask, NETMASK_ADDRESS[0], NETMASK_ADDRESS[1] , NETMASK_ADDRESS[2], NETMASK_ADDRESS[3]);
	  IP4_ADDR(&gw, GATEWAY_ADDRESS[0], GATEWAY_ADDRESS[1], GATEWAY_ADDRESS[2], GATEWAY_ADDRESS[3]);
}

void setup_network_interface() {
	  /* add the network interface (IPv4/IPv6) with RTOS */
	  netif_add(&gnetif, &ipaddr, &netmask, &gw, NULL, &ethernetif_init, &tcpip_input);
	  /* Registers the default network interface */
	  netif_set_default(&gnetif);

	  if (netif_is_link_up(&gnetif))
	  {
		/* When the netif is fully configured this function must be called */
		netif_set_up(&gnetif);
	  }
	  else
	  {
		/* When the netif link is down this function must be called */
		netif_set_down(&gnetif);
	  }
}
