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
    textSize(5);
    textAlign(CENTER, CENTER);
    fill(0);
    if (labeled) {
      for (int i=0; i<xNum; i++) {
        for (int j=0; j<yNum; j++) {
          if (labelData[i][j]!=0) {
            //ラベルデータの表示
            text(labelData[i][j], i*mazeaSize+mazeaSize/2, j*mazeaSize+mazeaSize/2);
          }
        }
      }
    }
  }
  void labeling(int x, int y, int n) {
    //println(n);
    //ラベルデータにnを入力
    //nはスタート地点からの遠さ（1がスタート地点、2がスタート地点の隣のマス）
    //隣のマスで、ラベルデータが0またはラベルデータが今いる個所以上、かつ壁でないならそのマスをラベル付けする
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

    //最初にゴール地点の座標とラベルデータが入る
    //ゴール地点の隣でラベルデータが1少ない個所を探す
    //これを再帰してmazeaDataが1になってゆく
    //これを表示するとスタートからゴールまでの道のりとなる

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