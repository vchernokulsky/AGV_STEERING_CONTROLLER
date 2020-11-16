typedef struct struct_recv_socket_t {
  int sock;
} struct_recv_socket;
struct_recv_socket recv_socket01;
osThreadId ThreadRecvHandle;
int i = 0;
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
    	i = i+1;
    }
  }
}
//---------------------------------------------------------------
static void send_thread(void *arg)
{
  int sock;
  struct sockaddr_in localhost, remotehost;
  uint32_t syscnt = 0;
  char buf[15] = {'a', 'b','c'};
  if ((sock = socket(AF_INET,SOCK_STREAM, 0)) >= 0)
  {
    memset(&localhost, 0, sizeof(struct sockaddr_in));
    localhost.sin_family = AF_INET;
    localhost.sin_port = htons(11411);
    localhost.sin_addr.s_addr = INADDR_ANY;
    if (bind(sock, (struct sockaddr *)&localhost, sizeof(struct sockaddr_in)) ==  0)
    {
      memset(&remotehost, 0, sizeof(struct sockaddr_in));
      remotehost.sin_family = AF_INET;
      remotehost.sin_port = htons(5446);
      ip4addr_aton("192.168.55.50",(ip4_addr_t*)&remotehost.sin_addr);
      if (connect(sock, (struct sockaddr *)&remotehost,sizeof(struct sockaddr_in)) >= 0)
      {

        recv_socket01.sock = sock;
        ThreadRecvHandle = sys_thread_new("recv_thread", recv_thread, (void*)&recv_socket01, DEFAULT_THREAD_STACKSIZE, osPriorityNormal);
        for(;;)
        {
          syscnt = osKernelSysTick();
          if(syscnt>50000)
          {
            close(sock);
            osThreadTerminate(ThreadRecvHandle);
            for(;;)
            {
              osDelay(1);
            }
          }
          write(sock,(void *) buf,strlen(buf));
          osDelay(1000);
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
