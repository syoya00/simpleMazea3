//2018.07.02 解析すたーと
int phase;

int mazeaSize = 10;
//壁の大きさ
//width/mazeaSize,height/mazeaSize が奇数になるよう設定する
Mazea mazea;
Player player;
int count;
Searcher searcher;

boolean debugMenu;
boolean errorMap;

void setup() {
  //(おそらく)processingの更新でsize内で変数が使えなくなったので適宜変更
  size(1210, 810);
  phase = 1;
  mazea = new Mazea(mazeaSize, width/mazeaSize, height/mazeaSize);
  player = new Player();
  count = 0;
  searcher = new Searcher(width/mazeaSize, height/mazeaSize);
  //なんのデバッグなのか不明
  //デバッグメニューをtrueにする時はerrorMapもtrueにするっぽい？
  //作る壁の数が出てくる
  //errorMapどこにも使ってない、作りかけ？
  debugMenu = false;
  errorMap = false;
}

void draw() {
  //.display = 描画処理
  //.move = 位置変更処理（今回はプレイヤーの動き入力のみ）

  background(0);
  mazea.display();
  searcher.display();
  player.display();
  if (count%10==0) {
    player.move();
  }
  count++;

  if (debugMenu) {
    debugWindow();
  }
}

void debugWindow() {
  noStroke();
  fill(100, 100, 100, 100);
  rect(0, 0, width, height);
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("debugWindow", width/2, 50);
  textSize(20);
  text("createWallNum : " + mazea.createWallNum, width/2, 150);
  textSize(20);
  if (errorMap) {
    fill(255, 0, 0);
    text("errorMap", width/2, 200);
  }
}

void reset() {
  mazea.reCreateNum = 0;
  player.reset();
  searcher.reset();
  mazea.resetMazea();
  //println(mazea.reCreateNum);
}