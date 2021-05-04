import java.io.*;
import java.util.*;
import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.Scanner;
import java.io.InputStreamReader;

import controlP5.*;
import java.util.Date;
import java.util.List.*;
import java.lang.Object.*;
import java.util.*;

import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.processing.*;

ControlP5 cp5;
Plot2 plotMotorParams;
Plot2 plotMotor2Params;
Motor testMotor;
Reductor reductor; 
int lastTime = 0;
float timeStep;
float pwm1 = 0;
float pwm2 = 0;
float Speed = 0;
float angularSpeed = 0;
SimplePlotList timelist;
SimplePlotList leftMotorRpm;
SimplePlotList rigthMotorRpm;
SimplePlotList leftPwm;
SimplePlotList rigthPwm;
SimplePlotList leftMt;
SimplePlotList rigthMt;
SimplePlotList SpeedP;
SimplePlotList angularSpeedP;

Chassis chassis;
Polygon polygon;

float ChasisMass = 1.8;
float ChasisIteria = 0.94;

boolean DrawFlag = false;

float ZOOM = 5;

void setup(){
  size(1024,768);
  frameRate(600);
  lastTime = millis();
  lastTime = 0;
  leftMotorRpm= new SimplePlotList(50);
  rigthMotorRpm = new SimplePlotList(50);
  leftPwm = new SimplePlotList(50);
  rigthPwm = new SimplePlotList(50);
  timelist = new SimplePlotList(50);
  leftMt  = new SimplePlotList(50);
  rigthMt = new SimplePlotList(50);
  SpeedP  = new SimplePlotList(50);
  angularSpeedP = new SimplePlotList(50);
  //leftMt  rigthMt
  CpSetup();
  chassis = new Chassis(2,0.94);
  polygon = new Polygon(5,500,10,10);
 
  plotMotorParams = new Plot2(600, 20,  940, 300, 10, 10);
  plotMotor2Params  = new Plot2(600, 360,  940, 700, 10, 10);
  
  //plotMotorParams = new Plot2(700, 360, 300, 300, 10, 10);
  for(int i = 0; i<50;i++){
    timelist.addData(float(i));
  }
}

void draw(){
  
  
  
  
  timeStep = timer();
  controller2pwm();
  //text(pwm1, 20, 40);
  //text(pwm2, 20, 60);
  
  chassis.setMassAndIteria(ChasisMass,ChasisIteria);
  chassis.nextIntegrationStep(timeStep);
  
  if(frameCount%10 == 0){
    background(0);
    polygon.SetDimWidth(ZOOM);
    polygon.drawFrame();
    chassis.wiew();
    leftMotorRpm.addData(chassis.driveLeft.motor.CurentRpm);
    rigthMotorRpm.addData(chassis.driveRigth.motor.CurentRpm);
    leftPwm.addData(pwm1);
    rigthPwm.addData(pwm2);
    leftMt.addData(chassis.driveLeft.motor.CurentT);
    rigthMt.addData(chassis.driveRigth.motor.CurentT);
    SpeedP.addData(chassis.totalSpeed2);
    angularSpeedP.addData(chassis.angularSpeed);
    
    plotMotorParams.horisontalAxis(timelist.data,color(255,255,255),"time");
    plotMotorParams.verticalAxis(leftMotorRpm.data,color(100,255,255),"Lrpm","left","right");
    plotMotorParams.verticalAxis(rigthMotorRpm.data,color(100,255,100),"Rrpm","left","left");
    plotMotorParams.verticalAxis(leftMt.data,color(255,255,100),"LM","right","right");
    plotMotorParams.verticalAxis(rigthMt.data,color(255,100,100),"RM","right","left");
    

  
  
    plotMotor2Params.horisontalAxis(timelist.data,color(255,255,255),"time");
    plotMotor2Params.verticalAxis(leftPwm.data,color(255,255,100),"pwm1","left","right");
    plotMotor2Params.verticalAxis(rigthPwm.data,color(255,100,100),"pwm2","left","left");
    plotMotor2Params.verticalAxis(SpeedP.data,color(100,255,255),"Speed","right","right");
    plotMotor2Params.verticalAxis(angularSpeedP.data,color(100,255,100),"AngleSp","right","left");
    
    PFont font = createFont("arial",12);
    textFont(font);
    fill(255,255,255);
    textAlign(LEFT);
    text("Framerate = " + str(frameRate) + " FPS",10,690-24);
    text("Integration TS = " + str(timeStep) + " Seconds",10,705-24);
  }
  
  //timelist.addData(float(millis())/1000);
  
    
  
  //text(chassis.CG.TransformedGeometryPoints.get(0).getSelfString() , 20 ,80);
  
  //testMotor.IntegrationEnergyInputStep(timeStep, pwm1);
  //drive.TestNextIntegrationStep(pwm1,timeStep);
  //rpm.addData(drive.speed);
  
  //plotSpeed.horisontalAxis(time.data,color(255,255,100),"Cd");
  //plotSpeed.verticalAxis(rpm.data,color(255,255,100),"Cl","rightSolo","right");
  //println(testMotor.getTorque(3500,1));
}

float timer(){
  float time = millis()-lastTime;
  lastTime = millis();
  time = time / 1000;
  return time;
}


void Dynamic(){
  
}
