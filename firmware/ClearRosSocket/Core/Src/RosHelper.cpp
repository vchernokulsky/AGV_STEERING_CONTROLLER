/*
 * RosHelper.c
 *
 *  Created on: Nov 20, 2020
 *      Author: developer
 */
#include "RosHelper.h"
#include "ros.h"

void ros_thread(void* arg){
	ros::NodeHandle nh;
	nh.initNode();
	for(;;){
		osDelay(1);
	}
}



