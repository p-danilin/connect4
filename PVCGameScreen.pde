class PVCGameScreen extends GameScreen {
  boolean isThinking = false;
  
  PVCGameScreen() {
    this.game = new Game();
    message = PLAYER_MOVE;
  }
  
  void draw() {
    drawBoard();
    displayMessage();
  }
  
  void mouseClicked() {
    if (checkHomeButton()) {
      return;
    }
    if (isThinking) {
      println("<<< mouseClicked - thinking");    
      return;
    }
    // user make a move
    int col = getClickedColumn();
    println("Column clicked: " + col);
    if (col >= 0 && col < Game.COLUMNS) {
      if (game.isColumnFull(col)) {
        message = "Column is full, pick another one";
        return;
      } else {
        if (game.dropCoin(col, Game.RED)) {
          screen = new EndScreen(game, "You are the champion, my friend!");
          return;
        }
        moveNum++;
      }
      
      // Artificial Int
      isThinking = true;
      message = "Thinking....";
      thread("think");
    }
    println("<<< mouseClicked");
  }
  
  void think() {
    int col = -1;
    if (moveNum == 2) {
      col = randomMove();
    } else {
      // run MinMax AI...
      int maxDepth = 8;
      if (moveNum >= 15) {
        if (moveNum <= 20) {
          maxDepth = 10;
        } else if (moveNum <= 23) {
          maxDepth = 11;
        } else {
          maxDepth = 12;
        }
      }

      Game gameCopy = new Game(game);
      println(">>> calculateTree");
      Node node = minMax.calculateTree(gameCopy, Game.BLUE, 0, maxDepth);
      println("<<< calculateTree");
      if (node.getBestMove() == -1) {
          screen = new EndScreen(game, "It's a draw, you will never beat me!");
          return;
      } else {
        col = node.getBestMove();
        // select random move with unknown result or a draw...
        if (node.getMove(col).getMinMaxScore() == 0 || node.getMove(col).getMinMaxScore() == 1  ) {
          col = randomDrawMove(node.getMoves(), node.getMove(col).getMinMaxScore());
        }
      }
    }
    println(">>> droppng coin to " + col);
    if (game.dropCoin(col, Game.BLUE)) {
      screen = new EndScreen(game, "I win, you loose!");
      return;
    } else {
      message = PLAYER_MOVE;
    }
    isThinking = false;
    moveNum++;
  }
  
  int randomMove() {
    return (int) random(5) + 1;
  }

  int randomDrawMove(Node[] moves, int score) {
    ArrayList<Integer> drawMoves = new ArrayList<Integer>();
    for (int c = 0; c < moves.length; c++) {
      if (moves[c] != null && moves[c].getMinMaxScore() == score) {
        drawMoves.add(c);
      }
    }
    return drawMoves.get((int) random(drawMoves.size()));
  }
}
