void keyTyped() {
  if (key=='w') {
    player.moveMode=0;
  } else if (key=='s') {
    player.moveMode=1;
  } else if (key=='a') {
    player.moveMode=2;
  } else if (key=='d') {
    player.moveMode=3;
  } else if (key=='r') {
    reset();
  } else if (key=='c') {
    //ゴールまでの道筋を探索＆表示
    //スタート地点と1を入力
    //ラベルデータ生成
    searcher.labeling(0, 0, 1);
    //ゴール地点とラベルデータを入力
    searcher.search(mazea.xGoal, mazea.yGoal, searcher.labelData[mazea.xGoal][mazea.yGoal]);
  } else if (key=='p') {
    //壁の数を増やしてリセット
    if (mazea.createWallNum<(mazea.xNum/2)*(mazea.yNum/2)) {
      mazea.createWallNum++;
      reset();
    }
    println("createWallNum " + mazea.createWallNum);
  } else if (key=='l') {
    //壁の数を減らしてリセット
    if (mazea.createWallNum>0) {
      mazea.createWallNum--;
      reset();
    }
    println("createWallNum " + mazea.createWallNum);
  } else if (key=='m') {
    //デバッグオンオフ
    debugMenu = !debugMenu;
  } else if (key=='o') {
    //使用用途不明、
    mazea.createMazea();
  }
}