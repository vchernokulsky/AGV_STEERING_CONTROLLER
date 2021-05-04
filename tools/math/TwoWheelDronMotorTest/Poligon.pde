/*
Класс полигон это та площадь по которой двиаются наши колёса
полигон содержит сектора с разными характеристиками покрытия
*/
class Polygon{
  ArrayList<sector> sectors =  new ArrayList<sector>();
  float DimWidth;
  float StartX;
  float StartY;
  float Width;
  ArrayList<vector> frame = new ArrayList<vector>();
  ArrayList<vector> wiewFrame = new ArrayList<vector>();
  float k;
  
   Polygon(float DimWidth, float Width , float StartX, float StartY){
     this.DimWidth = DimWidth;
     this.Width = Width;
     this.StartX = StartX;
     this.StartY = StartY;
     frame.add(new vector(-DimWidth/2, -DimWidth/2,0));
     frame.add(new vector(-DimWidth/2,  DimWidth/2,0));
     frame.add(new vector( DimWidth/2,  DimWidth/2,0));
     frame.add(new vector( DimWidth/2, -DimWidth/2,0));
     frame.add(new vector(-DimWidth/2, -DimWidth/2,0));
     k = Width/DimWidth; // Width = DimWidth/k;
     wiewFrame = GeometryConverter(frame);
   }
  
  void SetDimWidth(float DimWidth){
    this.DimWidth = DimWidth;
    k = Width/DimWidth;
  }
  
  ArrayList<vector> GeometryConverter(ArrayList<vector> inputGeometry){
    ArrayList<vector> outputGeometry = new ArrayList<vector>();
    outputGeometry.clear();
    vector translate = new vector(-DimWidth/2,-DimWidth/2,0);
    vector translateOnScreen = new vector(StartX,StartY+Width,0);
    vector scaleVector = new vector(k,-k,1);
    for(int i  = 0; i< inputGeometry.size(); i++){
      vector C = inputGeometry.get(i);
      C = C.subtract(C,translate);
      //C = C.scaleV(k);
      C = C.multElem(C,scaleVector);
      C = C.sum(C,translateOnScreen);
      outputGeometry.add(C);
    }
    return outputGeometry;
  }
  
  void drawGeometry(ArrayList<vector> geom, color col){
    for(int i = 0; i<geom.size()-1; i++){
      float Lx1 = geom.get(i).x;
      float Ly1 = geom.get(i).y;
      float Lx2 = geom.get(i+1).x;
      float Ly2 = geom.get(i+1).y;
      stroke(col);
      strokeWeight(1);
      line(Lx1,Ly1,Lx2,Ly2);
    }
  }
  
  void drawFrame(){
    
    strokeWeight(1);
    stroke(30,100,150);
    
    for(int i = 0; i<DimWidth/2; i++){
       float x = (i+DimWidth/2)*k+StartX;
       float y = -(i+DimWidth/2)*k+StartY+Width;
       float x2 = (-i+DimWidth/2)*k+StartX;
       float y2 = -(-i+DimWidth/2)*k+StartY+Width;
       line(StartX,y,StartX+Width,y);
       line(x,StartY,x,StartY+Width);
       line(StartX,y2,StartX+Width,y2);
       line(x2,StartY,x2,StartY+Width);
    }
    
    text("1m grid",StartX+5,StartY+15);
    
    drawGeometry(wiewFrame, color(255,255,255));
  }
}

class sector{
  String name;
  float positionX;
  float positionY;
  float sWidth;
  float sHeight;
  float AddRotateFricCoef; // добавочный коэффициент поверхности 
  float AddRotRandFricCoef; // добавочный рамдомный коэффициент поверхности " пыль камешки итд "
  
  sector(String name, float positionX, float positionY, float sWidth, float sHeight,
         float AddRotateFricCoef, float AddRotRandFricCoef){
    this.name = name;
    this.positionX = positionX;
    this.positionY = positionY;
    this.sWidth = sWidth;
    this.sHeight = sHeight;
    this.AddRotateFricCoef = AddRotateFricCoef;
    this.AddRotRandFricCoef = AddRotRandFricCoef;
  }
  
  //getFric(){
  //  
  //}
}
