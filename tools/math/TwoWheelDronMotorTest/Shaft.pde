class Wheel{  // это колесо
  float diametr; // диаметр колеса
  float circularFriction; // коэфициент сопротивления качению
  float areaFrictionKoef; // коэфициент сопротивления трения
  float RotationAngle = 0; // угол поворота колеса
  float RotationSpeed = 0;
  float areaAtForseKoef; // площадь контакта от веса
  float curentMomentFriction;
  float curentForseFriction;
  float iteria;
  vector wheelPosition;
  vector wheeDirection;
  
  Wheel(float diametr, float circularFriction, 
        float areaFrictionKoef, float areaAtForseKoef, float iteria){ //конструктор
    this.diametr = diametr;
    this.circularFriction = circularFriction;
    this.areaFrictionKoef = areaFrictionKoef;
    this.areaAtForseKoef = areaAtForseKoef;
    this.iteria = iteria;
    
  }
  
  float momentFrictionFunc(float inputMomen,float Mforse){
    if(abs(inputMomen)>curentMomentFriction){
      getCircularFrictionMoment(Mforse);
      return (abs(inputMomen) + curentMomentFriction)*sign(inputMomen);
    } else return (curentMomentFriction*sign(inputMomen)); //return 0;//
  }
  
  float getRpmAtLinear(float linear){
    float outRPM = linear/(diametr*PI)*60;
    return outRPM;
  }
  
  float forseFrictionFunc(float inputForse, float verticalForse){
    float frictionForse =  getFrictionForse(verticalForse);
    if(inputForse>frictionForse){
      return frictionForse;
    } else return inputForse;
    
  }
  
  void setPosition(vector NwheelPosition, vector NwheeDirection){
    wheelPosition = NwheelPosition;
    wheeDirection = NwheeDirection;
  }
  
  float getLinear(float input){ //косательные к коесу значения
    return input/diametr/2; 
  }
  
  float getLinearForse(float moment){
    float forse = moment/diametr/2;
    return forse;
  }
  
  float getFrictionForse(float forse){
    float area = areaAtForseKoef*forse;
    float frictionForse = area * forse * areaFrictionKoef;
    return frictionForse;
  }
  
  void getCircularFrictionMoment(float forse){
    curentMomentFriction = diametr/2 * circularFriction * forse;
    //return diametr/2 * circularFriction;
  }
}

class Reductor{
  float ratio;
  float efficiency;
  float maxMoment;

  
  Reductor(float ratio, float efficiency, float maxMoment){
    this.ratio = ratio;
    this.efficiency = efficiency;
    this.maxMoment = maxMoment;
  }
  
  
  float reductForvardMoment(float mom){
    float reductedMoment = (mom/ratio)*efficiency;
    return reductedMoment;
  }
  
  float reductBacSpeed(float rpm){
    float reductedRpm = rpm/ratio;
    return reductedRpm;
  }
}

class Motor{
  float MaxRpm;
  float NoLoadCurent;
  float MaxCurent;
  float MaxTorque;
  float motorIteria;
  float motorFric;
  float CurentRpm = 0.00000001;
  float deltaMoment = 0;
  float CurentT;
  
  Motor(float MaxRpm, float NoLoadCurent, float MaxCurent, float MaxTorque, float motorIteria){
    this.MaxRpm = MaxRpm;
    this.NoLoadCurent = NoLoadCurent;
    this.MaxCurent = MaxCurent;
    this.MaxTorque = MaxTorque;
    this.motorIteria = motorIteria;
    //this.motorFric = motorFric;
    this.motorFric = MaxTorque/MaxRpm;
  }
  
  float getTorque(float PWM){
    float curentMaxTorque = 0;
    float curentTorque = 0;
    float fricTorque = 0;
    float motorTorque = 0;
    //curentMaxTorque = CurentRpm
    if(CurentRpm!=0){
      fricTorque = map(CurentRpm,0,MaxRpm,0,MaxTorque);
      motorTorque = map(PWM,0,1,0,MaxTorque);
      //curentMaxTorque = MaxTorque;//map(abs(curentRpm),0,MaxRpm,MaxTorque,0);
      curentTorque = motorTorque-fricTorque;//*(abs(curentRpm)/curentRpm);
      //curentMaxTorque = map(CurentRpm,0,MaxRpm,MaxTorque,0);
      //curentTorque = map(PWM,0,1,0,curentMaxTorque);
      
    } else {
      curentTorque = map(PWM,0,1,0,MaxTorque);
    }
    CurentT = curentTorque+deltaMoment;
    float out = constrain(curentTorque+deltaMoment,-MaxTorque*2,MaxTorque*2);
    
    return CurentT;
  }
  
  void IntegrationEnergyInputStep(float timeStep, float pwm){
    float currentTorq = getTorque(pwm);
    float addSpeed = ((currentTorq)/motorIteria)*timeStep;//-motorFric*CurentRpm;
    //println(currentTorq);
    CurentRpm = CurentRpm+addSpeed/PI*60;
    //println(CurentRpm);
  }
  
  void SetRPM(float NewRpm ){
    float delataRpm = CurentRpm - NewRpm;
    deltaMoment = RPM2radianPerSecong(delataRpm)*motorIteria;
    CurentRpm = NewRpm;
  }
  
  float RPM2RPS(float RPM){
    return RPM/60;
  }
  
  float RPM2radianPerSecong(float RPM){
    return RPM/60*2*PI;
  }
  
}

class encoder{ // надо доработать
  float PulsePerTurn;
  
}



class Drive{
  Motor motor;
  Reductor reductor;
  Wheel wheel;
  float speed = 0;
  float distance = 0;
  Drive(Motor motor, Reductor reductor, Wheel wheel){
    this.motor = motor;
    this.reductor = reductor;
    this.wheel = wheel;
  }
  
  void TestNextIntegrationStep(float pwm, float timeStep){
    float motorMoment = motor.getTorque(pwm);
    float momenAfterReduction = reductor.reductForvardMoment(motorMoment);
    float wheelMoment = wheel.momentFrictionFunc(momenAfterReduction,10);    
    float wheelLinearForse = wheel.getLinearForse(wheelMoment);
    speed  = speed + (wheelLinearForse/10)*timeStep;
    distance = distance + speed/timeStep;
    float wheelRPM  = wheel.getRpmAtLinear(speed);
    float rpmAfterReduction = reductor.reductBacSpeed(wheelRPM);
    motor.CurentRpm = rpmAfterReduction;
    println(str(motorMoment) + " | " + 
            str(momenAfterReduction) + " | " + 
            str(wheelLinearForse) + " | " + 
            str(speed) + " | " + 
            str(wheelRPM) + " | " + 
            str(rpmAfterReduction));
  }
  
  float getShatfForse(float pwm, float wheelVerticalForse){
    float motorMoment = motor.getTorque(pwm);
    float momenAfterReduction = reductor.reductForvardMoment(motorMoment);
    float wheelMoment = wheel.momentFrictionFunc(momenAfterReduction,wheelVerticalForse);    
    float wheelLinearForse = wheel.getLinearForse(wheelMoment);
    /*
    println(str(motorMoment) + " | " + 
            str(momenAfterReduction) + " | " + 
            str(wheelLinearForse));
    */
    return wheelLinearForse;
  }
  
  void SetMotorRpm(float linearSpeed){
    float wheelRPM  = wheel.getRpmAtLinear(linearSpeed);
    float rpmAfterReduction = reductor.reductBacSpeed(wheelRPM);
    //motor.CurentRpm = rpmAfterReduction;
    motor.SetRPM(rpmAfterReduction);
  }

  
}


float sign(float Num){
  return abs(Num)/Num;
}
