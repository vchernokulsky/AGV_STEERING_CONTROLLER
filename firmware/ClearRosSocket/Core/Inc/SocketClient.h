/*
 * SocketClient.h
 *
 *  Created on: Nov 20, 2020
 *      Author: developer
 */

#ifndef INC_SOCKETCLIENT_H_
#define INC_SOCKETCLIENT_H_

#include "lwip/opt.h"
#include "lwip/arch.h"
#include "lwip/api.h"
#include "lwip/inet.h"
#include "lwip/sockets.h"

typedef struct struct_recv_socket_t {
  int sock;
} struct_recv_socket;
struct_recv_socket recv_socket01;
osThreadId ThreadRecvHandle;
osThreadId ThreadWriteHandle;



//---------------------------------------------------------------
static void recv_thread(void *arg)
{
  struct_recv_socket *arg_recv_socket;
  arg_recv_socket = (struct_recv_socket*) arg;
  int recv_data;
  char data_buffer[30] = {};
  for(;;)
  {
    recv_data = recv(arg_recv_socket->sock,data_buffer,sizeof(data_buffer),0);
    if(recv_data > 0)
    {
    	__NOP();
    }
  }
}
//static char buf[50] = "01234567890123456789012345678901234567890123456789";

static void write_thread(void *arg)
{
  struct_recv_socket *arg_recv_socket;
  arg_recv_socket = (struct_recv_socket*) arg;
  char buf[51] = "01234567890123456789012345678901234567890123456789";
  for(;;)
  {
	  write(arg_recv_socket->sock,(void *) buf,strlen(buf));
	  osDelay(20);
  }
}

static void simple_recv(uint8_t* data, uint16_t length)
{
   recv(recv_socket01.sock,data,length,0);
}

static void simple_write(uint8_t* data, uint16_t length)
{
	  write(recv_socket01.sock,(void *) data,length);
}
//---------------------------------------------------------------
static void send_thread(void *arg)
{
  int sock;
  struct sockaddr_in localhost, remotehost;
  if ((sock = socket(AF_INET,SOCK_STREAM, 0)) >= 0)
  {

    memset(&localhost, 0, sizeof(struct sockaddr_in));
    localhost.sin_family = AF_INET;
    localhost.sin_port = htons(5448);
    localhost.sin_addr.s_addr = INADDR_ANY;
    if (bind(sock, (struct sockaddr *)&localhost, sizeof(struct sockaddr_in)) ==  0)
    {
      memset(&remotehost, 0, sizeof(struct sockaddr_in));
      remotehost.sin_family = AF_INET;
      remotehost.sin_port = htons(11411);
      ip4addr_aton("192.168.55.52",(ip4_addr_t*)&remotehost.sin_addr);
      lwip_fcntl(sock, F_SETFL, (lwip_fcntl(sock, F_GETFL, 0)| O_NONBLOCK));
      osDelay(10);
      for(;;){
    	  connect(sock, (struct sockaddr *)&remotehost,sizeof(struct sockaddr_in));
    	  if(errno == EINPROGRESS || errno == 0)
		  {
			recv_socket01.sock = sock;
			sys_thread_new("ros_thread", ros_thread, NULL, DEFAULT_THREAD_STACKSIZE, osPriorityNormal);
	//        ThreadRecvHandle = sys_thread_new("recv_thread", recv_thread, (void*)&recv_socket01, DEFAULT_THREAD_STACKSIZE, osPriorityNormal);
	//        ThreadWriteHandle = sys_thread_new("write_thread", write_thread, (void*)&recv_socket01, DEFAULT_THREAD_STACKSIZE, osPriorityNormal);
	//        char buf[51] = "01234567890123456789012345678901234567890123456789";
			  for(;;)
			  {
	//        	  write(sock,(void *) buf,strlen(buf));
				  osDelay(20);
			  }
		  } else {
			  osDelay(500);
		  }
      }
    }
    else
    {
      close(sock);
      return;
    }
  }
}


#endif /* INC_SOCKETCLIENT_H_ */
