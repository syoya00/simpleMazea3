class Searcher {
  int mazeaSize;
  int xNum;
  int yNum;
  int mazeaData[][];
  int labelData[][];
  boolean labeled;
  Searcher(int x, int y) {
    mazeaSize = mazea.mazeaSize;
    xNum = x;
    yNum = y;
    mazeaData = new int[x][y];
    labelData = new int[x][y];
    labeled = true;
    reset();
  }
  void display() {
    stroke(100);
    strokeWeight(1);
    noStroke();
    fill(255, 0, 0, 100);
    for (int i=0; i<xNum; i++) {
      for (int j=0; j<yNum; j++) {
        if (mazeaData[i][j]==1) {
          rect(i*mazeaSize, j*mazeaSize, mazeaSize, mazeaSize);
        }
      }
    }
    textSize(20);
    textAlign(CENTER, CENTER);
    fill(0);
    if (labeled) {
      for (int i=0; i<xNum; i++) {
        for (int j=0; j<yNum; j++) {
          if (labelData[i][j]!=0) {
            //text(labelData[i][j], i*mazeaSize+mazeaSize/2, j*mazeaSize+mazeaSize/2);
          }
        }
      }
    }
  }
  void labeling(int x, int y, int n) {
    //println(n);
    labelData[x][y] = n;
    if (x+1<xNum) {
      if ((labelData[x+1][y]==0||labelData[x+1][y]>n)&&mazea.mazeaData[x+1][y]==0) {
        labeling(x+1, y, n+1);
      }
    }
    if (y+1<yNum) {
      if ((labelData[x][y+1]==0||labelData[x][y+1]>n)&&mazea.mazeaData[x][y+1]==0) {
        labeling(x, y+1, n+1);
      }
    }
    if (x-1>=0) {
      if ((labelData[x-1][y]==0||labelData[x-1][y]>n)&&mazea.mazeaData[x-1][y]==0) {
        labeling(x-1, y, n+1);
      }
    }
    if (y-1>=0) {
      if ((labelData[x][y-1]==0||labelData[x][y-1]>n)&&mazea.mazeaData[x][y-1]==0) {
        labeling(x, y-1, n+1);
      }
    }
    labeled = true;
  }
  void search(int x, int y, int n) {
    mazeaData[x][y] = 1;
    if (n>1) {
      if (x+1<xNum) {
        if (labelData[x+1][y]==n-1) {
          search(x+1, y, n-1);
        }
      }
      if (y+1<yNum) {
        if (labelData[x][y+1]==n-1) {
          search(x, y+1, n-1);
        }
      }
      if (x-1>=0) {
        if (labelData[x-1][y]==n-1) {
          search(x-1, y, n-1);
        }
      }
      if (y-1>=0) {
        if (labelData[x][y-1]==n-1) {
          search(x, y-1, n-1);
        }
      }
    }
  }
  void reset() {
    for (int i=0; i<xNum; i++) {
      for (int j=0; j<yNum; j++) {
        mazeaData[i][j] = 0;
        labelData[i][j] = 0;
      }
    }
  }
}

