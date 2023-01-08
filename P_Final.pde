boolean showCV;

void setup() {
  fullScreen();
  setupCV();
  setupGame();

  showCV = true;
}

void draw() {
  noCursor();
  updateCV();

  if (showCV == true) drawCV();
  else drawGame();
}
