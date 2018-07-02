class Mazea {
  int mazeaSize;
  int xNum;
  int yNum;
  int mazeaData[][];
  int createWallNum;
  boolean checker[][];
  int result;
  int reCreateNum;
  int xGoal;
  int yGoal;
  int createStep;
  Mazea(int ms, int x, int y) {
    mazeaSize = ms;
    xNum = x;
    yNum = y;
    mazeaData = new int[x][y];
    createWallNum = (xNum/2)*(yNum/2);
    checker = new boolean[x][y];
    result = 0;
    reCreateNum = 0;
    xGoal = x-1;
    yGoal = y-1;
    createStep = 0;
    //createMazea();
  }
  void display() {
    stroke(100);
    strokeWeight(1);
    noStroke();
    fill(255);
    for (int i=0; i<xNum; i++) {
      for (int j=0; j<yNum; j++) {

        if (mazeaData[i][j]==1) {
          fill(0);
        } else {
          fill(255);
        }

        if (i==0&&j==0) {
          fill(0, 255, 0);
        } else if (i==xGoal&&j==yGoal) {
          fill(255, 0, 0);
        }
        rect(i*mazeaSize, j*mazeaSize, mazeaSize, mazeaSize);
      }
    }
    createMazea();
  }
  void createMazea() {

    for (int k=0; k<10; k++) {

      if (createStep<(xNum/2)*(yNum/2)) {
        for (int i=0; i<xNum/2; i++) {
          for (int j=0; j<yNum/2; j++) {
            if (createStep==i*(yNum/2)+j) {
              mazeaData[i*2+1][j*2+1] = 1;
            }
          }
        }
      } else if (createStep<(xNum/2)*(yNum/2)+createWallNum) {
        //println("step : " + createStep);

        boolean complete = false;
        while (!complete) {
          int addX = int(random(0, xNum));
          int addY = 0;
          int ifClose = 0;
          if (addX%2==0) {
            addY = int(random(0, yNum/2))*2+1;
          } else {
            addY = int(random(0, yNum/2+1))*2;
          }
          //println("add : ", addX, addY);
          if (mazeaData[addX][addY]==0&&(addX+addY)%2==1) {
            mazeaData[addX][addY] = 1;
            complete = true;
            ifClose = 1;
          }
          resetChecker();
          mazeaCheck(0, 0);
          if (result!=xNum*yNum-createStep-1&&ifClose==1) {
            //println("close!");
            mazeaData[addX][addY] = 0;
            complete = false;
          }
        }
      }
      createStep++;
    }
  }
  void resetMazea() {
    for (int i=0; i<xNum; i++) {
      for (int j=0; j<yNum; j++) {
        mazeaData[i][j] = 0;
        checker[i][j] = false;
      }
    }
    result = 0;
    createStep = 0;
  }
  void resetChecker() {
    for (int i=0; i<xNum; i++) {
      for (int j=0; j<yNum; j++) {
        checker[i][j] = false;
      }
    }
    result = 0;
  }
  void mazeaCheck(int x, int y) {
    //閉所避け

    checker[x][y]=true;
    result++;

    if (x<xNum-1) {
      if (!checker[x+1][y]&&mazeaData[x+1][y]==0) {
        mazeaCheck(x+1, y);
      }
    }
    if (x>0) {
      if (!checker[x-1][y]&&mazeaData[x-1][y]==0) {
        mazeaCheck(x-1, y);
      }
    }
    if (y<yNum-1) {
      if (!checker[x][y+1]&&mazeaData[x][y+1]==0) {
        mazeaCheck(x, y+1);
      }
    }
    if (y>0) {
      if (!checker[x][y-1]&&mazeaData[x][y-1]==0) {
        mazeaCheck(x, y-1);
      }
    }
  }
}