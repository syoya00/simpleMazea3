class Player {
  int posX;
  int posY;
  int playerSize;
  int moveMode;
  Player() {
    posX = 0;
    posY = 0;
    playerSize = mazeaSize/2;
    moveMode = 0;
  }
  void display() {
    stroke(0);
    strokeWeight(1);
    fill(255, 255, 0);
    ellipse(posX*mazeaSize+mazeaSize/2, posY*mazeaSize+mazeaSize/2, playerSize, playerSize);
  }
  void move() {
    if (moveMode==0) {
      if (posY>0&&mazea.mazeaData[posX][posY-1]==0) {
        posY--;
      }
    } else if (moveMode==1) {
      if (posY<mazea.yNum-1&&mazea.mazeaData[posX][posY+1]==0) {
        posY++;
      }
    } else if (moveMode==2) {
      if (posX>0&&mazea.mazeaData[posX-1][posY]==0) {
        posX--;
      }
    } else if (moveMode==3) {
      if (posX<mazea.xNum-1&&mazea.mazeaData[posX+1][posY]==0) {
        posX++;
      }
    }
  }
  void reset() {
    posX = 0;
    posY = 0;
    moveMode = 0;
  }
}

