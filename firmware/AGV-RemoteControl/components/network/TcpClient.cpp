//
// Created by data-scientist on 12.08.2020.
//

#include "include/TcpClient.h"

SemaphoreHandle_t TcpClient::error_semaphore;
bool TcpClient::is_connected = false;

TcpClient::TcpClient( ) {
}

void TcpClient::init(const char *remote_ip, uint16_t port)
{
    TcpClient::error_semaphore = xSemaphoreCreateMutex();

    memset(&remotehost, 0, sizeof(struct sockaddr_in));
    remotehost.sin_addr.s_addr = inet_addr(remote_ip);
    remotehost.sin_family = AF_INET;
    remotehost.sin_port = htons(port);
}

void TcpClient::sock_recv(uint8_t *pData, uint16_t size, uint32_t* rdmaInd)
{
    if( xSemaphoreTake( TcpClient::error_semaphore, portMAX_DELAY) == pdTRUE ) {
        recv_data = (TcpClient::is_connected) ? recv(sock, pData, size, 0) : 0;
        vTaskDelay(2000 / portTICK_PERIOD_MS); // задержка, конвертируемая из мс в тики

        xSemaphoreGive( TcpClient::error_semaphore );
    }
    *rdmaInd = (recv_data > 0) ? recv_data : 0;

    if( check_errno(recv_data) == ERROR_STATUS){
        ++err_count;
    } else {
        if (err_count > 0){
            --err_count;
        }
    }
}

void TcpClient::sock_send(uint8_t *pData, uint16_t len)
{
    if( xSemaphoreTake( TcpClient::error_semaphore, portMAX_DELAY) == pdTRUE ) {
        send_data = (TcpClient::is_connected) ? send(sock, pData, len, 0): 0;
        xSemaphoreGive( TcpClient::error_semaphore );
    }

    if( check_errno(send_data) == ERROR_STATUS){
        ++err_count;
    } else {
        if (err_count > 0){
            --err_count;
        }
    }
}

void TcpClient::doTcpClientTask()
{
    for(;;) {
        if( xSemaphoreTake( TcpClient::error_semaphore, portMAX_DELAY) == pdTRUE ) {
            sock = socket(AF_INET, SOCK_STREAM, 0);
            xSemaphoreGive( TcpClient::error_semaphore);
        }

        if (sock >= 0) {
            err_count = 0;
            if( xSemaphoreTake( TcpClient::error_semaphore, portMAX_DELAY) == pdTRUE ) {
                fcntl(sock, F_SETFL, (fcntl(sock, F_GETFL, 0)| O_NONBLOCK));

                connect(sock, (struct sockaddr *)&remotehost, sizeof(remotehost));
                xSemaphoreGive( TcpClient::error_semaphore );
            }

            if (check_errno() == OK_STATUS) {
                if( xSemaphoreTake( TcpClient::error_semaphore, portMAX_DELAY) == pdTRUE ) {
                    TcpClient::is_connected = true;
                    xSemaphoreGive( TcpClient::error_semaphore);
                }
                for(;;) {
                    if(err_count > MAX_ERROR_COUNT){
                        if( xSemaphoreTake( TcpClient::error_semaphore, portMAX_DELAY) == pdTRUE ) {
                            TcpClient::is_connected = false;
                            xSemaphoreGive( TcpClient::error_semaphore );
                        }
                        break;
                    }
                    vTaskDelay(1);
                }
            }
            if( xSemaphoreTake( TcpClient::error_semaphore, portMAX_DELAY) == pdTRUE ) {
                close(sock);
                xSemaphoreGive( TcpClient::error_semaphore );
            }
        }
        vTaskDelay(1);
    }
}
uint8_t TcpClient::check_errno(int bytes){
    if (bytes < 0){
        return ERROR_STATUS;
    }
    return check_errno();
}
uint8_t TcpClient::check_errno()
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

void TcpClient::sock_recv_all(uint8_t *pData, uint16_t size) {
    uint16_t msg_recv_data_counter = 0;
    uint32_t rdmaInd = 0;

    while(msg_recv_data_counter < size) {
        sock_recv(&pData[msg_recv_data_counter], size - msg_recv_data_counter, (uint32_t*) &rdmaInd);
        msg_recv_data_counter += rdmaInd;
    }
}