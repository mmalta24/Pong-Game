import processing.sound.*;


//Musicas
SoundFile colision;
SoundFile endgame;
SoundFile trick;
SoundFile getpoints;

//Carregar Fonte
PFont font;

//Array de 2 duas paredes
Wall[] walls=new Wall[2];
float yWall=0;

//Array das barreiras dos jogadores
Barrier left;
Barrier right;
float xBarrier=50;
float arcStart=-HALF_PI;
float arcEnd=-HALF_PI+PI;


//Divisão da área de cada jogador
Line[] lines=new Line[9];
float yLine=20;

//Resultado de cada jogador
int player1=0;
int player2=0;

//bola
Puck puck;

//vencedor registo
String winner="";

//pausar o jogo
boolean paused=false;

//iniciar o jogo
boolean start=true;

//Imagem

PImage bomb;

//Tricks

int nTrick1=2;
int nTrick2=2;

int timeTrick1=0;
int timeTrick2=0;

int trick1=0;
int trick2=0;

//
int previousTime1=0;
int previousTime2=0;

//Microfone
AudioIn input;
Amplitude loudness;

void setupGame() {
  //Carregar os icones
  bomb= loadImage("data/bomb.jpg");

  //definir microfone
  // Create an Audio input and grab the 1st channel
  input = new AudioIn(this, 0);

  // Begin capturing the audio input
  input.start();
  // start() activates audio capture so that you can use it as
  // the input to live sound analysis, but it does NOT cause the
  // captured audio to be played back to you. if you also want the
  // microphone input to be played back to you, call
  //    input.play();
  // instead (be careful with your speaker volume, you might produce
  // painful audio feedback. best to first try it out wearing headphones!)

  // Create a new Amplitude analyzer
  loudness = new Amplitude(this);

  // Patch the input to the volume analyzer
  loudness.input(input);

  //Construir as duas barreiras

  left= new Barrier(50, -HALF_PI, -HALF_PI+PI);
  right= new Barrier(width-53, HALF_PI, HALF_PI+PI);

  //Carregar as musicas do jogo

  colision=new SoundFile(this, "data/colision.wav");
  trick=new SoundFile(this, "data/trick.wav");
  getpoints=new SoundFile(this, "data/getpoints.wav");
  endgame=new SoundFile(this, "data/endgame.wav");

  //Contrução de dos limites verdes
  for (int i=0; i<walls.length; i++) {
    walls[i]=new Wall(yWall);
    yWall=height-25;
  }

  //Contrução de dos linhas descontinuas verdes
  for (int i=0; i<lines.length; i++) {
    lines[i]=new Line(yLine);
    yLine+=122;
  }
  puck=new Puck();

  //Carregamento da Fonte
  font = createFont("data/PressStart2P-Regular.ttf", 128);
}

void drawGame() {  
  background(2, 0, 59);

  if (numDetectedBodies == 2) {
    start=false;
  }

  if (winner=="") {
    if (paused==false && start==false) {
      if (trick1!=22 && trick2!=12) {
        left.update(leftHandRight.y, 0.5);
        right.update(rightHandLeft.y, 0.5 );
      } else if (trick1!=22 && trick2==12) {
        right.update(rightHandLeft.y, 0.5);
      } else if (trick1==22 && trick2!=12) {
        left.update(rightHandRight.y, 0.5);
      }
    }
  }


  if (timeTrick1>0) {
    if (second()-previousTime1>= 50) {
      previousTime1 = second();
      timeTrick1--;
      print(timeTrick1);
    }
  } else {
    trick1=0;
    previousTime1=0;
  }

  if (timeTrick2>0) {
    if (second()-previousTime2>= 50) {
      previousTime2 = second();
      timeTrick2--;
      print(timeTrick2);
    }
  } else {
    trick2=0;
    previousTime2=0;
  }

  puck.checkBarrierRight(right);
  puck.checkBarrierLeft(left);

  //Desenhar info
  fill(31, 36, 73);
  noStroke();
  rect(20, 40, 360, 50);
  fill(255);
  textFont(font, 14);
  text("Press SPACE (Start/Pause)", 29, 73);

  //Barreiras
  left.show();
  right.show();



  //Desenha os dois limites
  for (int i=0; i<walls.length; i++) {
    walls[i].show();
  }


  // Desenha o resultado
  fill(255);
  textFont(font, 100);
  text(player1, width/2-150, 200);
  text(player2, width/2+70, 200);

  //Desenha as linhas descontínuas
  for (int i=0; i<lines.length; i++) {
    lines[i].show();
  }

  //Bola
  if (winner=="") {
    if (paused==false && start==false) {
      puck.update(0.03);
      puck.edges();
    }
  }
  puck.show();

  ////Desenhar info vencedor
  if (winner!="") {
    fill(31, 36, 73);
    noStroke();
    rect(width/2-600/2, height/2-100/2, 600, 100);
    fill(255);
    textFont(font, 20);
    text("Congratulations "+winner+" !!!", width/2-270, height/2+10);
  }

  ////Desenhar info jogo em pausa
  if (paused==true) {
    fill(31, 36, 73);
    noStroke();
    rect(width/2-300/2, height/2-50/2, 300, 50);
    fill(255);
    textFont(font, 20);
    text("Game Paused !", width/2-125, height/2+10);
  }

  //player 1 truques
  image(bomb, 430, 30, 70, 70);
  fill(250, 249, 83);
  textFont(font, 35);
  text(nTrick1, 400, 90);

  //player 2 truques
  image(bomb, width-80, 30, 70, 70);
  fill(250, 249, 83);
  textFont(font, 35);
  text(nTrick2, width-110, 90);

  ////Desenhar info para começar
  if (start==true) {
    fill(31, 36, 73);
    noStroke();
    rect(width/2-630/2, height/2-100/2, 630, 100);
    fill(255);
    textFont(font, 20);
    text("Need 2 Individuals to Start ", width/2-260, height/2+10);
  }
}
