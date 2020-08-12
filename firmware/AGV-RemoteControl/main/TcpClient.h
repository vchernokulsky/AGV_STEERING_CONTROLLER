//
// Created by data-scientist on 12.08.2020.
//

#ifndef AGV_REMOTECONTROL_TCPCLIENT_H
#define AGV_REMOTECONTROL_TCPCLIENT_H

#include "lwip/err.h"
#include "lwip/sockets.h"
#include "lwip/sys.h"
#include <lwip/netdb.h>
#include <cstring>

#include "freertos/semphr.h"

#define OK_STATUS 0
#define WARNING_STATUS 1
#define ERROR_STATUS 2
#define UNKNOWN_STATUS 3

#define MAX_ERROR_COUNT 10

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
    virtual ~TcpClient();

    void init(uint16_t ros_local_port, const char *remote_ip, uint16_t ros_serialnode_port);
    void sock_recv(char *pData, uint16_t size, uint32_t* rdmaInd);
    void sock_recv_all(char *pData, uint16_t size);
    void sock_send(char *pData, uint16_t len);
    void tcpClientLoop();
};


#endif //AGV_REMOTECONTROL_TCPCLIENT_H
