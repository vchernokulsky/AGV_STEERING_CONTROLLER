#!/usr/bin/env python

# Echo server program
import socket
from time import sleep
import threading

conn = None

def recv(conn):
    while True:
         data = conn.recv(1024).decode()
         print(data)
         
try:
    HOST = '0.0.0.0'          # Symbolic name meaning the local host
    PORT = 5446              # Arbitrary non-privileged port
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.bind((HOST, PORT))
    s.listen(1)
    print('listening on port ', PORT)
    conn, addr = s.accept()
    print('Connected by', addr)
    threading.Thread(target=recv, args=[conn]).start()
    while 1:
        conn.send(b'set\0' + bytearray([0x00, 0x08, 0xdc, 0xab, 0xcd, 0xef]))
        print('sent')
        sleep(1.0)

    conn.close()
    print('close')
        #sleep(5.0)
except Exception as e:
    print(str(e))
    if conn:
        conn.close()


