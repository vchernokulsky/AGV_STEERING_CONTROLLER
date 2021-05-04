class Chassis{
  float mass;
  float iteria;
  vector Position = new vector(0,0,0);
  float DirectionAngle = 0;
  float angularSpeed = 0;
  float totalSpeed;
  float totalSpeed2 = 0;
  vector SpeedVector = new vector(0,0,0);
  vector directionVector = new vector(1,0,0);
  vector forseVector = new vector(0,0,0);
  vector accelVector = new vector(0,0,0);
  
  ChassisGeometry CG = new ChassisGeometry(new vector(0,0,0));
  
  Wheel wheelLeft = new Wheel(0.2,0.03,0.02,0.5,0.01);
  Wheel wheelRigth = new Wheel(0.2,0.03,0.02,0.5,0.01);
  
  Motor motorLeft = new Motor(7000,0.2,6,0.088,0.001);
  Motor motorRigth = new Motor(7000,0.2,6,0.088,0.001);
  
  
  Reductor reductorLeft = new Reductor(1.0/27,0.80,12);
  Reductor reductorRigth = new Reductor(1.0/27,0.80,12);
  
  Drive driveLeft = new Drive(motorLeft,reductorLeft,wheelLeft);
  Drive driveRigth = new Drive(motorRigth,reductorRigth,wheelRigth);
  
  Chassis(float mass, float iteria){
    this.mass = mass;
    this.iteria = iteria;
    driveLeft.wheel.setPosition(new vector(0,-0.2,0), new vector(1,0,0));
    driveRigth.wheel.setPosition(new vector(0, 0.2,0), new vector(1,0,0));
  }
  
  void setMassAndIteria(float mass, float iteria){
    this.mass = mass;
    this.iteria = iteria;
  }
  
  void nextIntegrationStep(float timeStep){
    float wheelDirectonForseLeft = driveLeft.getShatfForse(pwm1,mass/2*9.8); // получаем касательную силу колеса
    float wheelDirectonForseRigth = driveRigth.getShatfForse(pwm2,mass/2*9.8); // получаем касательную силу правого колеса
    
    float wheelReactionForseLeft = driveLeft.wheel.getFrictionForse(mass/2*9.8); // сила тения на колесе
    float wheelReactionForseRigth = driveRigth.wheel.getFrictionForse(mass/2*9.8); // сила трения на колесе
    
    float wheelsDistance = abs(driveLeft.wheel.wheelPosition.y)+abs(driveRigth.wheel.wheelPosition.y); // расстояние между колёсами для рассчёта момента
    
    float moment1 = -wheelDirectonForseLeft * wheelsDistance; //моент левого колеса 
    float moment2 = wheelDirectonForseRigth * wheelsDistance; //момент правого колеса
    //println(wheelDirectonForseLeft);
    
    float TotalMomen = moment1 + moment2; // суманый момент
    angularSpeed = angularSpeed + (TotalMomen/iteria)*timeStep - angularSpeed*0.009; // приращение угловой скорости усчкорение включено
    DirectionAngle = DirectionAngle + angularSpeed*timeStep; // получение угла поворота корпуса
    //DirectionAngle = PI/6;
    
    
    quaternion rotationQuat = new quaternion(0,0,1,1); // обявление кватерниона поворота
    rotationQuat =  rotationQuat.Euler2Qaterz(new vector(0,0,DirectionAngle)); // получение кватерниона из углов эйлера
    vector directionRotateVector = directionVector.QatVectRotate(rotationQuat,directionVector); // вращение единичного вектора направления
    
    directionRotateVector = directionRotateVector.VectNormalize(directionRotateVector);
    
    vector directionVector2 = new vector(-1,0,0);
    vector directionRotateVector2 = directionVector2.QatVectRotate(rotationQuat,directionVector2);
    directionRotateVector2 = directionRotateVector2.VectNormalize(directionRotateVector2);
    // колёсные силы;
    
    //float totalSpeed = SpeedVector.selfLength(); 
    float totalSpeed = SpeedVector.VectorDotProd2(SpeedVector,directionRotateVector);
    vector direktionSpeed = directionRotateVector.multK(directionRotateVector,abs(totalSpeed));
    vector direktionSpeed2 = directionRotateVector.multK(directionRotateVector2,abs(totalSpeed));
 
   
    float angleSpeedWheel = direktionSpeed.Vectors2angle(direktionSpeed,SpeedVector);
    float angleSpeedWheel2 = direktionSpeed.Vectors2angle(direktionSpeed,SpeedVector);
    
    
      vector deltaSpeed = direktionSpeed.subtract(direktionSpeed ,SpeedVector);
      
    if(totalSpeed<0){
      deltaSpeed = direktionSpeed.subtract(direktionSpeed2,SpeedVector);
    }
    
    if(-PI/20>angleSpeedWheel && angleSpeedWheel>PI/20){
      deltaSpeed = new vector(0,0,0);
    }
    

    
    
    vector deltaAccel = deltaSpeed.multK(deltaSpeed,1.0/timeStep);
    vector delataForse = deltaAccel.multK(deltaAccel,mass);
    
    float deltaForseLength =  delataForse.selfLength();
    
    if(deltaForseLength>wheelReactionForseLeft+wheelReactionForseRigth){
      delataForse = delataForse.VectNormalize(delataForse);
      delataForse = delataForse.multK(delataForse,(wheelReactionForseLeft+wheelReactionForseRigth));
      //println("скольжение");
    }
    
    
    delataForse = delataForse.multK(delataForse,0.80);
    
    //println(wheelReactionForseLeft);
    //delataForse.selfDisp();
    
    
    directionRotateVector = directionRotateVector.VectNormalize(directionRotateVector);
    float TotalForse = wheelDirectonForseLeft+wheelDirectonForseRigth;
    
    forseVector = directionRotateVector.multK(directionRotateVector,TotalForse);
    forseVector = forseVector.sum(forseVector,delataForse);
    accelVector = forseVector.multK(forseVector,1.0/mass);
    SpeedVector = SpeedVector.sum(SpeedVector,forseVector.multK(accelVector,timeStep));
    SpeedVector = SpeedVector.sum(SpeedVector,SpeedVector.multK(SpeedVector,-0.0001));
    Position  = Position.sum(Position,SpeedVector.scaleV(timeStep));
    
    vector A =  directionRotateVector.VectNormalize(directionRotateVector);
    totalSpeed2 = SpeedVector.selfLength();
    A = A.multK(A,totalSpeed2);
    
    float wheelLeftLinearSpeed = 0;
    float wheelRigthLinearSpeed = 0;
    if(totalSpeed>0){
      wheelLeftLinearSpeed = totalSpeed2+angularSpeed*(-wheelsDistance/2);
      wheelRigthLinearSpeed = totalSpeed2+angularSpeed*(wheelsDistance/2);
    } else {
      wheelLeftLinearSpeed = -totalSpeed2+angularSpeed*(-wheelsDistance/2);
      wheelRigthLinearSpeed = -totalSpeed2+angularSpeed*(wheelsDistance/2);
    }
    
    driveLeft.SetMotorRpm(wheelLeftLinearSpeed);
    driveRigth.SetMotorRpm(wheelRigthLinearSpeed);
    
    //println(str(wheelLeftLinearSpeed) + " | " + str(wheelRigthLinearSpeed));
    //println(TotalForse);
    //forseVector.selfDisp();
    //SpeedVector.selfDisp();
    
    
    /*
    println(str(TotalMomen) + " | " + 
            str(iteria) + " | " + 
            str(timeStep) + " | " + 
            str(TotalMomen) + " | " + 
            str(angularSpeed) + " | " + 
            str(DirectionAngle));
    */
  }
  
  void wiew(){
    CG.calcTransformedGeometry(Position, DirectionAngle);
    CG.wiev();
  }
  
}

class ChassisGeometry{
  float[] Gy = {0  , 0.1, 0.4,   0.4,   0.1 , 0,   -0.1, -0.4, -0.4,  -0.1,  0};
  float[] Gx = {0.45, 0.4, 0.38, -0.38, -0.4, -0.4, -0.4, -0.38, 0.38,  0.4,  0.45};
  vector rotateCenter = new vector(0,0,0);
  ArrayList<vector> GeometryPoints = new ArrayList<vector>();
  ArrayList<vector> TransformedGeometryPoints = new ArrayList<vector>();
  
  ChassisGeometry(vector rotateCenter){
    this.rotateCenter = rotateCenter;
    GeometryPoints.clear();
    for(int i = 0; i<Gx.length; i++){
      GeometryPoints.add(new vector(Gx[i],Gy[i],0));
    }
  }
  
  void calcTransformedGeometry(vector translate, float rotate){
    TransformedGeometryPoints.clear();
    quaternion rot = new quaternion(0,0,1,1);
    rot =  rot.Euler2Qaterz(new vector(0,0,rotate));
    for(int i = 0; i<GeometryPoints.size(); i++){
      vector v = GeometryPoints.get(i);
      v = v.subtract(v,rotateCenter);
      v = v.QatVectRotate(rot,v);
      v = v.sum(v,translate);
      TransformedGeometryPoints.add(v);
    }
  }
  
  void wiev(){
    ArrayList<vector> wievG = polygon.GeometryConverter(TransformedGeometryPoints);
    polygon.drawGeometry(wievG,color(255,255,0));
  }
  
}
