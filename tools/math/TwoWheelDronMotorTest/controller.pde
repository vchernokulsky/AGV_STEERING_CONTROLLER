void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      Speed = 1; 
    } 
    if (keyCode == DOWN) {
      Speed = -1; 
    }
    if (keyCode == LEFT) {
      angularSpeed = -1; 
    } 
    if (keyCode == RIGHT) {
      angularSpeed = 1; 
    }
    
  }
}

void keyReleased() {
if (key == CODED) {
    if (keyCode == UP) {
      Speed = 0; 
    } 
    if (keyCode == DOWN) {
      Speed = 0; 
    }
     if (keyCode == LEFT) {
      angularSpeed = 0; 
    } 
    if (keyCode == RIGHT) {
      angularSpeed = 0; 
    }
  }
}


void controller2pwm(){
  pwm1 = Speed + angularSpeed;
  pwm2 = Speed - angularSpeed;
  
  pwm1 = constrain(pwm1,-1,1);
  pwm2 = constrain(pwm2,-1,1);
}
