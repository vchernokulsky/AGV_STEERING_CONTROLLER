#pragma once

/******************** NETWORK ************************/
#define DEFAULT_ROBOT_IP_ADRESS {192, 168, 2, 115}
#define DEFAULT_NETWORK_MASK {255, 255, 255, 0}
#define DEFAULT_GATEAWAY {192, 168, 2, 1}
#define DEFAULT_DHCP_CONFIG false
#define DEFAULT_ROS_CLIENT_PORT 10888
#define DEFAULT_SETUP_SERVER_PORT 11511
/************************************************/

/********************SERVER************************/
#define DEFAULT_ROS_SERIALNODE_IP_ADRESS {192, 168, 2, 64}
#define DEFAULT_ROS_SERIALNODE_PORT 11411
/************************************************/

/***************ROBOT***************************/
#define DEFAULT_CMDVEL_TOPIC "/cmd_vel"
#define DEFAULT_ODOMETRY_TOPIC "/odom"
#define DEFAULT_BASE_FRAME "base_link"
#define DEFAULT_ODOMETRY_FRAME "odom"

#define DEFAULT_MAX_PWD_ALLOWED 255
// Intems MiniBot
//#define DEFAULT_RAD_PER_TICK 0.0157
//#define DEFAULT_RADIUS 0.035
//#define DEFAULT_WHEEL_SEPARATION 0.17

// Intems Ant
#define DEFAULT_RAD_PER_TICK 0.01745
#define DEFAULT_RADIUS 0.1
#define DEFAULT_WHEEL_SEPARATION 0.45

#define DEFAULT_MAX_LIN_SPEED 0.9
#define DEFAULT_ANG_VEL_MAX 0.2

/************* Motor driver type ***************/
/** for BB driver required only LEN, REN RPWM **/
#define DEFAULT_DRIVER_TYPE IBT

/************************************************/
