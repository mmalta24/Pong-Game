class Puck {
  float x=width/2;
  float y=height/2;
  PVector speed;
  float r=17;

  Puck() {
    reset();
  }
  
  //verfica as colisões
  void checkBarrierLeft(Barrier b) {
    if (y<b.y+b.l/2 && y>b.y-b.l/2 && x-r<b.x+b.c/2) {
      if (x>b.x) {
        colision.play();
        speed.x *=-1;
      }
    }
  }

  void checkBarrierRight(Barrier b) {
    if (y<b.y+b.l/2 && y>b.y-b.l/2 && x+r>b.x-b.c/2) {
      if (x<b.x) {
        colision.play();
        speed.x *=-1;
      }
    }
  }


  void update(float percentagem) {



    if (speed.mag() > 10) speed.mult(1.0 - percentagem);
    if (speed.mag()  < 10) speed.setMag(10);
    x=x+speed.x;
    y=y+speed.y;

    input.amp(1.0);
    // loudness.analyze() return a value between 0 and 1. To adjust
    // the scaling and mapping of an ellipse we scale from 0 to 0.5
    float volume = loudness.analyze();
    speed.setMag(speed.mag() + 50.0 * volume);
    if (speed.mag() > 50) speed.setMag(50);
  }

  void show() {
    if (trick1!=21 && trick2!=11) {
      fill(255);
    } else if (trick1!=21 && trick2==11) {
      if (x<width/2) {
        fill(2, 0, 59);
      } else {
        fill(255);
      }
    } else if (trick1==21 && trick2!=11) {
      if (x>width/2) {
        fill(2, 0, 59);
      } else {
        fill(255);
      }
    }
    ellipse(x, y, r*2, r*2);
  }

  void reset() {
    x=width/2;
    y=height/2;
    float angle=random(-PI/4, PI/4);
    speed = new PVector(10* cos(angle), 10 * sin(angle)); 

    if (random(1)<0.5) {
      speed.x *= -1;
    }
  }

  void edges() {
    if (y<50 || y>height-50) {
      speed.y*=-1;
    }
    if (x-r>width) {
      //ding.play();

      player1++;
      nTrick1=2;
      nTrick2=2;

      timeTrick1=0;
      timeTrick2=0;

      trick1=0;
      trick2=0;

      previousTime1=0;
      previousTime2=0;
      getpoints.play();
      if (player1==3) {
        winner="PLAYER1";
        endgame.play();
      }
      reset();
    }
    if (x+r<0) {
      //ding.play();
      player2++;

      nTrick1=2;
      nTrick2=2;

      timeTrick1=0;
      timeTrick2=0;

      trick1=0;
      trick2=0;

      previousTime1=0;
      previousTime2=0;
      getpoints.play();
      if (player2==3) {
        winner="PLAYER2";
        endgame.play();
      }
      reset();
    }
  }
}
