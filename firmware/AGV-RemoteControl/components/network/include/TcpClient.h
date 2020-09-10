//
// Created by data-scientist on 12.08.2020.
//

#ifndef AGV_REMOTECONTROL_TCPCLIENT_H
#define AGV_REMOTECONTROL_TCPCLIENT_H

#include "lwip/err.h"
#include "lwip/sockets.h"
#include "lwip/sys.h"
#include <lwip/netdb.h>
#include "freertos/semphr.h"
#include <cstring>

#define OK_STATUS 0
#define WARNING_STATUS 1
#define ERROR_STATUS 2
#define UNKNOWN_STATUS 3

#define MAX_ERROR_COUNT 100
#define RECV_WAIT_NUM 100

class TcpClient {
    int sock;
    int recv_data;
    int send_data;
    int err_count;

    struct sockaddr_in localhost, remotehost;
    socklen_t sockaddrsize;

    SemaphoreHandle_t send_semaphore;

    uint8_t check_errno();
    uint8_t check_errno(int bytes);
public:
    static SemaphoreHandle_t error_semaphore;
    static bool is_connected;

    TcpClient();

    void init(const char *remote_ip, uint16_t port);
    void sock_recv(uint8_t *pData, uint16_t size, uint32_t* rdmaInd);
    bool sock_recv_all(uint8_t *pData, uint16_t size);
    void sock_send(uint8_t *pData, uint16_t len);
    void doTcpClientTask();
};


#endif //AGV_REMOTECONTROL_TCPCLIENT_H
