class Barrier{
  float x; 
  float y=height/2;
  float c=20;
  float l=170;
  float arcB;
  float arcF;
  float ychange=0;
  Barrier (float xR, float arcS, float arcE) {  
    x = xR; 
    arcB=arcS;
    arcF=arcE;
  } 
  void update(float posY, float easing){
    y= (1.0 - easing) * y + easing * posY;
    y=constrain(y,l/2+52,(height-l/2)-52);
  }
  void move(float steps){
    ychange=steps;
  }
  
  void show(){
    fill(255);
    noStroke();
    arc(x, y, 40, 200, arcB, arcF,CHORD);
  }
  
}
