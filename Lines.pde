class Line{
  float x=width/2-9;
  float y;
  float w=20;
  float h=70;
  
  
  Line(float yL){
    y=yL;
  }
  
  void show(){
    fill(222, 215, 6);
    rect(width/2-9, y, w, h);
  }
}
