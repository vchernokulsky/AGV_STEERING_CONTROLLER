void CpSetup(){
  cp5 = new ControlP5(this);
  PFont font = createFont("arial",15);
  int position_x = 10;
  int start_position_y = 690;
  int position_k = 24;
  
  cp5.addSlider("ChasisMass")
     .setPosition(position_x,start_position_y+position_k*1)
     .setSize(450,20)
     .setRange(1.5,5)
     .setValue(ChasisMass)
     ;
     
  cp5.addSlider("ChasisIteria")
     .setPosition(position_x,start_position_y+position_k*2)
     .setSize(450,20)
     .setRange(0.094,1.5)
     .setValue(ChasisIteria)
     ;
  
  cp5.addSlider("ZOOM")
     .setPosition(position_x,start_position_y+position_k*0)
     .setSize(450,20)
     .setRange(1,30)
     .setValue(ZOOM)
     ;
}
