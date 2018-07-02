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
    searcher.labeling(0, 0, 1);
    searcher.search(mazea.xGoal, mazea.yGoal, searcher.labelData[mazea.xGoal][mazea.yGoal]);
  } else if (key=='p') {
    if (mazea.createWallNum<(mazea.xNum/2)*(mazea.yNum/2)) {
      mazea.createWallNum++;
      reset();
    }
    println("createWallNum " + mazea.createWallNum);
  } else if (key=='l') {
    if (mazea.createWallNum>0) {
      mazea.createWallNum--;
      reset();
    }
    println("createWallNum " + mazea.createWallNum);
  } else if (key=='m') {
    debugMenu = !debugMenu;
  } else if (key=='o') {
    mazea.createMazea();
  }
}

