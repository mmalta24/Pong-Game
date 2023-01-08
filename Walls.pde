class Wall{
  float x; 
  float y=height/2;
  float c=width;
  float l=25;
  Wall (float yR) {  
    y = yR;  
  } 
  
  void show(){
    fill(222, 215, 6);
    noStroke();
    rect(x, y, c, l);
  }
}
