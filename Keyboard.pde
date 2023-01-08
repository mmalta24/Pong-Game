void keyReleased() {
  left.move(0);
  right.move(0);
}

void keyPressed() {
  if (key=='a') {
    left.move(-10);
  } else if (key=='z') {
    left.move(10);
  } else if (key=='j') {
    right.move(-10);
  } else if (key=='m') {
    right.move(10);
  } else if (key==' ') {
    if (paused==false) {
      paused=true;
    } else {
      paused=false;
    }
  } else if (key=='r') {
    if (winner!="") {
      player1=0;
      player2=0;
      winner="";
      nTrick1=2;
      nTrick2=2;

      timeTrick1=0;
      timeTrick2=0;

      trick1=0;
      trick2=0;

      previousTime1=0;
      previousTime2=0;
    }
  } else if (key=='q') {
    if (nTrick1==2) {
      if (timeTrick1==0) {
        trick.play();
        timeTrick1=10;
        nTrick1--;
        trick1=22;
      }
    } else if (nTrick1==1) {
      if (timeTrick1==0) {
        trick.play();
        timeTrick1=10;
        nTrick1--;
        trick1=21;
      }
    }
  } else if (key=='p') {
    if (nTrick2==2) {
      if (timeTrick2==0) {
        trick.play();
        timeTrick2=10;
        nTrick2--;
        trick2=12;
      }
    } else if (nTrick2==1) {
      if (timeTrick2==0) {
        trick.play();
        timeTrick2=10;
        nTrick2--;
        trick2=11;
      }
    }
  } else if (key=='s') {
    start=false;
  } else if (key == 'x') {
    showCV = !showCV;
  }

  if (keyCode == UP) limiar = limiar + 0.01;
  else  if (keyCode == DOWN) limiar = limiar - 0.01;
  limiar = constrain(limiar, 0.01, 0.99);
  println(limiar);
}
