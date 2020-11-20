/*
 * SocketServer.h
 *
 *  Created on: Nov 20, 2020
 *      Author: developer
 */

#ifndef INC_SOCKETSERVER_H_
#define INC_SOCKETSERVER_H_

unsigned char out_buffer[250];
typedef struct struct_client_socket_t {
  struct sockaddr_in remotehost;
  socklen_t sockaddrsize;
  int accept_sock;
} struct_client_socket;
struct_client_socket client_socket01;
static void client_socket_thread(void *arg)
{
  int buflen = 150;
  int ret, accept_sock;
  struct sockaddr_in remotehost;
  socklen_t sockaddrsize;
  struct_client_socket *arg_client_socket;
  arg_client_socket = (struct_client_socket*) arg;
  remotehost = arg_client_socket->remotehost;
  sockaddrsize  = arg_client_socket->sockaddrsize;
  accept_sock = arg_client_socket->accept_sock;

    ret = recvfrom( accept_sock,out_buffer, buflen, 0, (struct sockaddr *)&remotehost, &sockaddrsize);
    if(ret > 0)
    {

        sendto(accept_sock,out_buffer,strlen((char*)out_buffer),0,(struct sockaddr *)&remotehost, sockaddrsize);
        osDelay(100);

    }

  close(accept_sock);
  osThreadTerminate(NULL);
}
osThreadId ServerSendRecv;
//---------------------------------------------------------------
static void tcp_thread(void *arg)
{
  int sock, accept_sock;
  struct sockaddr_in address, remotehost;
  socklen_t sockaddrsize;
  if ((sock = socket(AF_INET,SOCK_STREAM, 0)) >= 0)
  {
    address.sin_family = AF_INET;
    address.sin_port = htons(11511);
    address.sin_addr.s_addr = INADDR_ANY;
    if (bind(sock, (struct sockaddr *)&address, sizeof (address)) ==  0)
    {
    	listen(sock, 5);
      for(;;)
      {
        accept_sock = accept(sock, (struct sockaddr *)&remotehost, (socklen_t *)&sockaddrsize);
        if(accept_sock >= 0)
        {

          client_socket01.accept_sock = accept_sock;
          client_socket01.remotehost = remotehost;
          client_socket01.sockaddrsize = sockaddrsize;
          ServerSendRecv = sys_thread_new("client_socket_thread", client_socket_thread, (void*)&client_socket01, DEFAULT_THREAD_STACKSIZE, osPriorityNormal );
          __NOP();
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



#endif /* INC_SOCKETSERVER_H_ */
