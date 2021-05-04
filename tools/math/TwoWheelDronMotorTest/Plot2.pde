class Plot2{
  float X1 = 120;
  float Y1 = 50;
  float X2 = 500;
  float Y2 = 450;  
  float GraphWidth = X2-X1;
  float HaxLine = Y2+10;
  float GraphHeigth = Y2-Y1;
  int GridHNum = 10;
  int GridVNum = 10;
  float[] Hax;
      
  Plot2(float X1, float Y1, float X2, float Y2, int GridHNum, int GridVNum){
    this.X1 = X1;
    this.Y1 = Y1;
    this.X2 = X2;
    this.Y2 = Y2;
    this.GridHNum = GridHNum;
    this.GridVNum = GridVNum;   
    GraphWidth = X2-X1;
    HaxLine = Y2+10;
    GraphHeigth = Y2-Y1;
    
  }
  

  int decade(float number){
    int i;
    for(i = -5; i<15; i++){
      float decade = pow(10,i);
      if(abs(number)<decade){
        break;
      }  
    }
    return i;
  }
  
  
  float[] scale(float[] data){
    float Mx = max(data);
    float mx = min(data);
    float[] sc = new float[2];
    //println(str(Mx)+" | "+str(mx));
    float max_dec = decade(Mx);
    float min_dec = decade(mx);
    //println(str(max_dec)+" | "+str(min_dec));
      float D = max_dec-min_dec;
      if(D==0){
        sc[0] = pow(10,max_dec-1)*ceil(Mx/pow(10,max_dec-1));
        sc[1] = pow(10,min_dec-1)*floor(mx/pow(10,min_dec-1));
      } else if(D<0){
        sc[0] = pow(10,min_dec-1)*ceil(Mx/pow(10,min_dec-1));
        sc[1] = pow(10,min_dec-1)*floor(mx/pow(10,min_dec-1));
      } else if(D>0){
        sc[0] = pow(10,max_dec-1)*ceil(Mx/pow(10,max_dec-1));
        sc[1] = pow(10,max_dec-1)*floor(mx/pow(10,max_dec-1));
      }
    return sc;
  }
  
  
  void Vaxis (float[] data, float[] Hax, float H , float X, float Y, String type, color C, String name, int nV){
    fill(C);
    stroke(C);
    
    float[] sc = scale(data);
    //println(str(sc[0])+" | "+str(sc[1]));
    float[] out = new float[data.length];
    float zero = map(sc[0],sc[1],sc[0],Y+H,Y);
    float Yax  = map(sc[1],sc[1],sc[0],Y+H,Y);
    line(X,zero,X,Yax);
    strokeWeight(1);
    int Ns = nV;
    if(type.equals("left")){
      
      for(int i = 0; i<=Ns;i++){
        float y = map(i,0,Ns,Y+H,Y);
        float d = map(i,0,Ns,sc[1],sc[0]);
        line(X-3,y,X,y);
        textAlign(RIGHT, CENTER);
        textSize(8);
        text(nfs(d,0,3),X-8,y);
        
      }
       text(name,X-2,Y-10);
    }
      if(type.equals("right")){
      for(int i = 0; i<=Ns;i++){
        float y = map(i,0,Ns,Y+H,Y);
        float d = map(i,0,Ns,sc[1],sc[0]);
        line(X,y,X+3,y);
        textAlign(LEFT, CENTER);
        textSize(8);
        text(nfs(d,0,3),X+6,y);
      }
      text(name,X+2,Y-10);
    }
    
    for(int i = 0; i<data.length; i++){
       out[i] = map(data[i],sc[1],sc[0],Y+H,Y);
    }
    
    for(int i = 0; i<data.length-1; i++){
      strokeWeight(1);
      line(Hax[i], out[i], Hax[i+1], out[i+1]);
      strokeWeight(1);
    }
    
  }
  
  float[] Haxis(float[] data, float L , float X, float Y, String type, color C, String name, int nH){
    fill(C);
    stroke(C);
    float[] sc = scale(data);
    float zero = map(sc[0],sc[1],sc[0],X,X+L);
    float Xax  = map(sc[1],sc[1],sc[0],X,X+L);
    float[] out = new float[data.length];
    
    line(zero,Y,Xax,Y);
    
    int Ns = nH;
    
     for(int i = 0; i<=Ns;i++){
        float x = map(i,0,Ns,X,X+L);
        float d = map(i,0,Ns,sc[1],sc[0]);
        line(x,Y,x,Y+3);
        textAlign(CENTER, TOP);
        textSize(8);
        text(nfs(d,0,2),x,Y+5);
     }
     text(name,X+L+30,Y+5);
     for(int i = 0; i<data.length; i++){
       out[i] = map(data[i],sc[1],sc[0],X,X+L);
     }
     return out;
  }
  
  void grid(float[] dZ, int nV,int nH){
   float H = dZ[3]-dZ[1];
    float L = dZ[2]-dZ[0];
    float stepH = H/nV;
    float stepV = L/nH;
    for(int i = 0; i <= nV; i++){
      stroke(100,100,100);
      strokeWeight(0.5);
      line(dZ[0],dZ[1]+stepH*i,dZ[2],dZ[1]+stepH*i);
    }
    for(int i = 0; i <= nH; i++){
      stroke(100,100,100);
      strokeWeight(0.5);
      line(dZ[0]+stepV*i,dZ[1],dZ[0]+stepV*i,dZ[3]);
    }
    
    strokeWeight(1); 
  }

  void verticalAxis(float[] data, color C, String Name, String type1, String type2){
    float axisPosition = 0;
    if(type1.equals("leftSolo")&&type2.equals("left")){
      axisPosition = X1-10;
    }
    if(type1.equals("left")&&type2.equals("left")){
      axisPosition = X1-44;
    }
    if(type1.equals("left")&&type2.equals("right")){
      axisPosition = X1-40;
    }
    if(type1.equals("right")&&type2.equals("left")){
      axisPosition = X2+40;
    }
    if(type1.equals("rightSolo")&&type2.equals("right")){
      axisPosition = X2+10;
    }
    if(type1.equals("right")&&type2.equals("right")){
      axisPosition = X2+44;
    }
    
    Vaxis(data, Hax, GraphHeigth, axisPosition,  Y1, type2, C, Name,  GridVNum);
  }
  
  void horisontalAxis(float[] data, color C, String Name){
    float[] Dz = {X1, Y1, X2, Y2};
    grid(Dz, GridVNum*2,GridHNum*2);
    Hax = Haxis(data,  GraphWidth, X1, HaxLine, "none", C, Name, GridHNum);
  }
  
  

}


class SimplePlotList{
 float[] data;
 int len;
 
 SimplePlotList(int len){
   this.len = len;
   data = new float[len];
   zerosData();
 }
 
 void addData(float d){
   for(int i = 0; i<len-1;i++){
     data[i] = data[i+1];
   }
   data[len-1] = d;
 }
 
 void zerosData(){
   for(int i = 0; i<len;i++){
     data[i] = 0;
   }
 }
 
 float[] getArray(){
   return data;
 }
  
}
