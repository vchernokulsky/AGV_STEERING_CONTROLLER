/*
 * SocketHelper.cpp
 *
 *  Created on: Jan 31, 2020
 *      Author: developer
 */

#include "SocketClient.h"

bool SocketClient::is_connected = false;

SocketClient::SocketClient( )
{
	// TODO Auto-generated constructor stub
}

void SocketClient::init(uint16_t ros_local_port, uint8_t *remote_ip, uint16_t ros_serialnode_port)
{
	memset(&localhost, 0, sizeof(struct sockaddr_in));
	localhost.sin_family = AF_INET;
	localhost.sin_port = htons(ros_local_port);
	localhost.sin_addr.s_addr = INADDR_ANY;

	memset(&remotehost, 0, sizeof(struct sockaddr_in));
	remotehost.sin_family = AF_INET;
	remotehost.sin_port = htons(ros_serialnode_port);
	ip4_addr_set_u32((ip4_addr_t*)&remotehost.sin_addr, remote_ip[0] | (remote_ip[1] << 8) | (remote_ip[2] << 16) | (remote_ip[3] << 24));
}

SocketClient::~SocketClient() {
	// TODO Auto-generated destructor stub
}

void SocketClient::socket_receive(uint8_t *pData, uint16_t size, uint32_t* rdmaInd)
{
	osDelay(10);
	//if( xSemaphoreTake( SocketClient::error_semaphore, portMAX_DELAY) == pdTRUE )
	//{
		recv_data = (SocketClient::is_connected) ? recv(sock, pData, size, 0) : 0;
		//osDelay(500);
	//	xSemaphoreGive( SocketClient::error_semaphore );
	//}
	*rdmaInd = (recv_data > 0) ? recv_data : 0;

	if( check_errno(recv_data) == ERROR_STATUS){
		++err_count;
	} else {
		if (err_count > 0){
			--err_count;
		}
	}
}

void SocketClient::socket_send(uint8_t *pData, uint16_t len)
{
	//if( xSemaphoreTake( SocketClient::error_semaphore, portMAX_DELAY) == pdTRUE )
	//{
		send_data = (SocketClient::is_connected) ? write(sock,(void *) pData, len) : 0;
	//	xSemaphoreGive( SocketClient::error_semaphore );
	//}
	if( check_errno(send_data) == ERROR_STATUS){
			++err_count;
		} else {
			if (err_count > 0){
				--err_count;
			}
		}
}

void SocketClient::SocketClientTask()
{
	for(;;)
	{
		sock = socket(AF_INET,SOCK_STREAM, 0);

		if (sock >= 0)
		{
			err_count = 0;
			osDelay(10);
			lwip_fcntl(sock, F_SETFL, (lwip_fcntl(sock, F_GETFL, 0)| O_NONBLOCK));
			osDelay(10);
			connect(sock, (struct sockaddr *)&remotehost,sizeof(struct sockaddr_in));
			osDelay(400);

			if (check_errno() == OK_STATUS)
			{
				osDelay(500);
				SocketClient::is_connected = true;
				osDelay(500);

				for(;;){
					if(err_count > MAX_ERROR_COUNT){
						HAL_GPIO_WritePin(GPIO_LWIP_LED, PIN_LWIP_LED, GPIO_PIN_RESET);
						SocketClient::is_connected = false;
						break;
					} else
					{
						HAL_GPIO_WritePin(GPIO_LWIP_LED, PIN_LWIP_LED, GPIO_PIN_SET);
					}
					osDelay(10);
				}
			}
			close(sock);
			osDelay(500);
		}
		osDelay(100);
	}
}
uint8_t SocketClient::check_errno(int bytes){
	if (bytes < 0){
		return ERROR_STATUS;
	}
	return check_errno();
}
uint8_t SocketClient::check_errno()
{
	if(errno == EINPROGRESS || errno == 0)
	{
		return OK_STATUS;
	}
	if(errno == EAGAIN)
	{
		return WARNING_STATUS;
	}
	if(errno == ECONNRESET || errno == EHOSTUNREACH)
	{
		return ERROR_STATUS;
	}
	return UNKNOWN_STATUS;
}

bool SocketClient::socket_receive_all(uint8_t *pData, uint16_t size) {
	uint16_t msg_recv_data_counter = 0;
	uint32_t rdmaInd = 0;
	uint16_t recv_try = RECV_WAIT_NUM;

	while(msg_recv_data_counter < size) {
		socket_receive((uint8_t*) &pData[msg_recv_data_counter], size - msg_recv_data_counter, (uint32_t*) &rdmaInd);
		if (rdmaInd == 0 && (msg_recv_data_counter==0 || --recv_try == 0)){
			break;
		}
		msg_recv_data_counter += rdmaInd;
	}
	return msg_recv_data_counter == size;
}
