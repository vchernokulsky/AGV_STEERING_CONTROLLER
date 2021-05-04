float[] lineCrossDot(float x1, float y1, float x2, float y2,
                     float x3, float y3, float x4, float y4){
  float Ua=((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3))/
     ((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
  float Ub=((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))/
     ((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
  
  float x = x1+Ua*(x2-x1);
  float y = y1+Ua*(y2-y1);
  
  x=x3+Ub*(x4-x3);
  y=y3+Ub*(y4-y3);
  
  float[] dot = {x,y};
  return dot;
}



float vect2angle(float ax, float ay, float bx, float by){
  
  float n1 = sqrt(pow(ax,2)+pow(ay,2));
  float n2 = sqrt(pow(bx,2)+pow(by,2));
  
  float anx =  ax/n1; float any = ay/n1;
  float bnx =  bx/n2; float bny = by/n2;
  
  float Dot = anx*bnx+any*bny;
  float alfa = acos(Dot);
  
  return alfa;
}


float[] vectRotate(float[] vect, float alfa){
  float[] vect2 = new float[2];
  
  vect2[0] = cos(alfa)*vect[0] + sin(alfa)*vect[1];
  vect2[1] = -sin(alfa)*vect[0] + cos(alfa)*vect[1];
  
  return vect2;
  
}



class quaternion{
  float a, b, c, d;
  quaternion(float qa, float qb, float qc, float qd){
    a = qa; b = qb; c = qc; d = qd;
  }
  
  quaternion(vector axis, float angle){
    axis = axis.VectNormalize(axis);
    float sinA = sin(angle/2);
    a = cos(angle/2); 
    b = axis.x*sinA;
    c = axis.y*sinA;
    d = axis.z*sinA;
  }
  
  void QatNormalize(){
    float norm = sqrt(pow(a,2) + pow(b,2) + pow(c,2) + pow(d,2));
    a = a/norm; b = b/norm; c = c/norm; d = d/norm;
  }
  
  quaternion QaterzProduct(quaternion q1, quaternion q2){
    float A=(q1.a + q1.b) * (q2.a + q2.b);
    float B=(q1.d - q1.c) * (q2.c - q2.d);
    float C=(q1.b - q1.a) * (q2.c + q2.d);
    float D=(q1.c + q1.d) * (q2.b - q2.a);
    float E=(q1.b + q1.d) * (q2.b + q2.c);
    float F=(q1.b - q1.d) * (q2.b - q2.c);
    float G=(q1.a + q1.c) * (q2.a - q2.d);
    float H=(q1.a - q1.c) * (q2.a + q2.d);
    
    float a1 =  B+(-E-F+G+H)*0.5;
    float b1 =  A-( E+F+G+H)*0.5;
    float c1 = -C+( E-F+G-H)*0.5;
    float d1 = -D+( E-F-G+H)*0.5;
    
    quaternion q3 = new quaternion(a1, b1, c1, d1);
    return q3;
  }
  
  public quaternion Euler2Qaterz(vector v){
    float c1 = cos(v.y/2);
    float c2 = cos(v.z/2);
    float c3 = cos(v.x/2);
    
    float s1 = sin(v.y/2);
    float s2 = sin(v.z/2);
    float s3 = sin(v.x/2);
    
  
    quaternion q = new quaternion( c1 * c2 * c3 - s1 * s2 * s3,
                                   s1 * s2 * c3 + c1 * c2 * s3,
                                   s1 * c2 * c3 + c1 * s2 * s3,
                                   c1 * s2 * c3 - s1 * c2 * s3);
    
    return q;
  } 
  
  quaternion QatSLERPfilt(quaternion q1,quaternion q2, float K){
    
    float SummPowQat1 = pow(q1.a,2) + pow(q1.b,2) + pow(q1.c,2) + pow(q1.d,2);
    float norm1 = sqrt(SummPowQat1);
    //float aa = q.a/norm1;  float ab = q.b/norm1;  float ac = q.c/norm1;  float ad = q.d/norm1;
    
    float SummPowQat2 = pow(q2.a,2) + pow(q2.b,2) + pow(q2.c,2) + pow(q2.d,2);
    float norm2 = sqrt(SummPowQat2);
    //a = a/norm2;   b = b/norm2;   c = c/norm2;   d = d/norm2;
    
    float DOT = (q1.a*q2.a + q1.b*q2.b + q1.c*q2.c + q1.d * q2.d)/(norm1*norm2);
  
    /*  
    Serial.print("K = ");    Serial.println(k,3);
    Serial.print("DOT = ");  Serial.println(DOT,3);
    Serial.print("q.a = ");    Serial.print(q.a,3); 
    Serial.print(" q.b = ");   Serial.print(q.b,3);
    Serial.print(" q.c = ");   Serial.print(q.c,3);
    Serial.print(" q.d = "); Serial.println(q.d,3);
    */
         
    if(DOT < 0.0){ DOT = -DOT; q1.a = -q1.a; q1.b = -q1.b; q1.c = -q1.c; q1.d = -q1.d;}
  
    
    float theta_0 = acos(DOT);
    float theta = theta_0*K;          
    float sin_theta = sin(theta);     
    float sin_theta_0 = sin(theta_0); 
  
    float s0 = cos(theta) - DOT * sin_theta / sin_theta_0;
    float s1 = sin_theta / sin_theta_0;
    

    
    quaternion q3 = new quaternion ( q1.a*s0 + q2.a*s1,
                                     q1.b*s0 + q2.b*s1,
                                     q1.c*s0 + q2.c*s1,
                                     q1.d*s0 + q2.d*s1);
    return q3;
  }
  
  quaternion QaterzInvert(quaternion q){
    quaternion q2 = new quaternion(q.a, -q.b, -q.c, -q.d);
    return q2;
  }
  
   quaternion QatVectProduct(quaternion q1, vector v1){
    float a1 = -q1.b * v1.x - q1.c * v1.y - q1.d * v1.z;
    float b1 =  q1.a * v1.x + q1.c * v1.z - q1.d * v1.y;
    float c1 =  q1.a * v1.y - q1.b * v1.z + q1.d * v1.x;
    float d1 =  q1.a * v1.z + q1.b * v1.y - q1.c * v1.x;
    quaternion q2 = new quaternion(a1,b1,c1,d1);
    return q2;
  }
  
  Vec3D getQatAxis(){
    float alfa = acos(a);
    float x = b/sin(alfa);
    float y = c/sin(alfa);
    float z = d/sin(alfa);
    return new Vec3D(x,y,z);
  }
  
  float getQatAngle(){
    float alfa = acos(a);
    return a;
  }
  
  void disp(){
    println(a+" | "+b+" | "+c+" | "+d);
  }
  
}



class vector{
  float x, y, z;
  vector(float ax, float ay, float az){
    x = ax; y = ay; z = az;
  }
  
  vector(Vec3D v){
    x = v.x; y = v.y; z = v.z;
  }
  
  vector VectNormalize(vector v){
    float norm = sqrt(pow(v.x,2) + pow(v.y,2) + pow(v.z,2));
    v.x = v.x/norm; v.y = v.y/norm; v.z = v.z/norm;
    return v;
  }
  
  float VectorDotProd(vector v1, vector v2){
    float SummPowVect1 = pow(v1.x,2) + pow(v1.y,2) + pow(v1.z,2);
    float SummPowVect2 = pow(v2.x,2) + pow(v2.y,2) + pow(v2.z,2);
    float DOT = (v1.x*v2.x + v1.y*v2.y + v1.z*v2.z)/
          (sqrt(SummPowVect1)*sqrt(SummPowVect2));
    return DOT;
  }
  
  float VectorDotProd2(vector v1, vector v2){
    float DOT = (v1.x*v2.x + v1.y*v2.y + v1.z*v2.z);
    return DOT;
  }
  
  vector VectCrossProd(vector v1, vector v2){
    float xc = v1.y*v2.z - v1.z*v2.y;
    float yc = v1.z*v2.x - v1.x*v2.z;
    float zc = v1.x*v2.y - v1.y*v2.x;
    
    vector v3 = new vector(xc, yc, zc);
    return v3;
  }
  
  float Vectors2angle(vector v1, vector v2){
    
  float alfa = acos(VectorDotProd(v1, v2));
    return alfa;
  }
  
  vector QatVectRotate(quaternion q, vector v2){
    //VectNormalize();
    quaternion q1;
    quaternion q2;
    quaternion q3;
    //q1.QatNormalize(q);
    //quaternion q2 = q1; //q2.q.a = q1.q.a; q2.q.b = q1.q.b; q2.q.c = q1.q.c; q2.q.d = q1.q.d;
    q1=q;
    q1 = q1.QaterzInvert(q);
    q2 = q.QatVectProduct(q,v2); //q2.QatNormalize();
    q3 = q2.QaterzProduct(q2, q1);
    
    //v.x = q1.b; v.y = q1.c; v.z = q1.d;
    vector v1 = new vector(q3.b, q3.c, q3.d);
    return v1;
  }
  
  vector Processing2Normal(vector V){
    vector V2 = new vector(V.z,V.x,-V.y);
    return V2;
  }
  
  vector Normal2Processing(vector V){
    vector V2 = new vector(V.y,-V.z,V.x);
    return V2;
  }
  
  vector projection(vector V1,float[][] M){
    vector X = new vector(M[0][0],M[0][1],M[0][2]); //X.disp(X);
    vector Y = new vector(M[1][0],M[1][1],M[1][2]); //Y.disp(Y);
    vector Z = new vector(M[2][0],M[2][1],M[2][2]); //Z.disp(Z);
    vector V2 = new vector(V1.VectorDotProd2(V1,X),V1.VectorDotProd2(V1,Y),V1.VectorDotProd2(V1,Z));
    return V2;
  }
  
  vector sum(vector V,vector V1){
    vector V2 = new vector(V.x+V1.x,V.y+V1.y,V.z+V1.z);
    return V2;
  }
  
  vector subtract(vector V,vector V1){
    vector V2 = new vector(V.x-V1.x,V.y-V1.y,V.z-V1.z);
    return V2;
  }
  
  vector multK(vector V,float K){
    vector V2 = new vector(V.x*K,V.y*K,V.z*K);
    return V2;
  }
  
  vector multElem(vector V,vector V1){
    vector V2 = new vector(V.x*V1.x,V.y*V1.y,V.z*V1.z);
    return V2;
  }
  
  vector divElem(vector V,vector V1){
    vector V2 = new vector(V.x/V1.x, V.y/V1.y, V.z/V1.z);
    return V2;
  }
    
  void disp(vector V){
    println(V.x+" | "+V.y+" | "+V.z);
  }
  
  void selfDisp(){
    println(x+" | "+y+" | "+z);
  }
  
  String getSelfString(){
    String out = str(x)+" | "+ str(y) + " | " + str(z);
    return out;
  }
  
  Vec3D getVec3D(){
    return new Vec3D(x,y,z);
  }
  
  vector FromVec3D(Vec3D V){
    return new vector(V.x, V.y, V.z);
  }
  
  vector invert(){
    return new vector(-x,-y,-z);
  }
  
  vector scaleV(float K){
    return new vector(x*K,y*K,z*K);
  }
  
  float selfLength(){
    return sqrt(pow(x,2) + pow(y,2) + pow(z,2));
  }
  
}



vector vectLineCrossDot(vector v1, vector v2, vector v3, vector v4){

  
float x1=v1.x;
float y1=v1.z;

float x2=v2.x;
float y2=v2.z;

float x3=v3.x;
float y3=v3.z;

float x4=v4.x;
float y4=v4.z;

float Ua=((x4-x3)*(y1-y3)-(y4-y3)*(x1-x3))/
         ((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));
   
float Ub=((x2-x1)*(y1-y3)-(y2-y1)*(x1-x3))/
         ((y4-y3)*(x2-x1)-(x4-x3)*(y2-y1));


float x=x1+Ua*(x2-x1);
float y=y1+Ua*(y2-y1);


x=x3+Ub*(x4-x3);
y=y3+Ub*(y4-y3);


return new vector(x,0,y);
}
