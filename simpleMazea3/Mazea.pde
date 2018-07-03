class Mazea {
  //xNum,yNum = 縦横マス数
  //mazeaData = 迷路の情報
  //mazeaData[縦マス][横マス]
  //0：通過可能（道）
  //1：通過不可能（壁）
  //xGoal,yGoal = ゴールのx,yマス数
  //現在スタート地点は0,0と直に入力している

  //createWallNum = 最初に生成する壁に追加して生成する壁の数
  //この値が少ないほど迷路は単純になる
  //ただし、少なすぎるとゴールをうまく探索できない
  //最大は(xNum/2)*(yNum/2)
  //ここから1でも（無理やり）増やすとエラーで正しく生成されない
  /////////////////////////////////////////////////////////////
  //理由としては「最初に生成する壁」全てから「4方向のうちいずれかの1方向に壁を追加している」から
  //こうすることで閉路をうまないようにしている
  //この最大値から一つでも壁を追加すると閉路ができるため
  //閉路ができない限り必ずゴールできる迷路となる
  /////////////////////////////////////////////////////////////


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
    createWallNum = (xNum/2)*(yNum/2)-100;
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

    //生成速度をあげるためにk=10にしてある
    //迷路が生成される様子を観察するための実装
    //一瞬で作る場合適切な修正が必要
    for (int k=0; k<10; k++) {

      if (createStep<(xNum/2)*(yNum/2)) {
        //9×9の中心に壁がある状態にする
        //このとき、xNum/2,yNum/2は小数点を含む整数になる

        for (int i=0; i<xNum/2; i++) {
          for (int j=0; j<yNum/2; j++) {
            if (createStep==i*(yNum/2)+j) {
              //このif文によってforループ中のcreateStepと数が合う1個所だけに壁が生成される
              mazeaData[i*2+1][j*2+1] = 1;
            }
          }
        }
      } else if (createStep<(xNum/2)*(yNum/2)+createWallNum) {
        //追加の壁を生成
        //println("step : " + createStep);

        boolean complete = false;
        while (!complete) {
          //addX,addY = 生成候補個所
          int addX = int(random(0, xNum));
          int addY = 0;
          int ifClose = 0;
          //ランダムに決められたx座標によって、最初に生成された壁と被らないよう生成候補個所を決める
          if (addX%2==0) {
            addY = int(random(0, yNum/2))*2+1;
          } else {
            addY = int(random(0, yNum/2+1))*2;
          }
          //println("add : ", addX, addY);
          if (mazeaData[addX][addY]==0&&(addX+addY)%2==1) {
            //既に壁が生成された場所でなければ壁を生成
            //ループを抜けられるようになる
            mazeaData[addX][addY] = 1;
            complete = true;
            ifClose = 1;
          }
          resetChecker();
          mazeaCheck(0, 0);
          //上の二つの関数で「迷路内のすべての場所に行けるかどうか」をチェックする
          //resultが　全マス数 - 今まで生成されたはずのマス数 - 1　となる
          //この条件を満たしていない場合、さっき生成した壁をなくしてループを継続
          if (result!=xNum*yNum-createStep-1&&ifClose==1) {
            //println("close!");
            mazeaData[addX][addY] = 0;
            complete = false;
          }
        }
      }
      //壁の数を一つ増やす
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

    //スタート地点から壁でないマスを探索
    //再帰関数で数え上げる

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