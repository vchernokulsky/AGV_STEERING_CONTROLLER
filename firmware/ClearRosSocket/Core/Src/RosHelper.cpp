/*
 * RosHelper.c
 *
 *  Created on: Nov 20, 2020
 *      Author: developer
 */
#include "RosHelper.h"
#include "ros.h"
#include <std_msgs/String.h>

void ros_thread(void* arg){
	ros::NodeHandle nh;
	std_msgs::String str_msg;
	ros::Publisher chatter("chatter", &str_msg);

	nh.initNode();
	nh.advertise(chatter);
	str_msg.data = "Hello world!";
	for(;;){
		chatter.publish(&str_msg);
		nh.spinOnce();
		osDelay(500);
	}
}



