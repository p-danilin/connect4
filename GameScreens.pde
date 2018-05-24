class Screen {
  void draw() {}
  void think() {}
  void mouseClicked() {}
}

class GameScreen extends Screen {
  static final int BACKGROUND = #F3EFE0;
  static final String PLAYER_MOVE = "Please make your move";
  
  Game game;
  int moveNum = 1;
  String message = null;
  boolean isThinking = false;
  
  GameScreen(Game game) {
    this.game = game;
    message = PLAYER_MOVE;
  }
  
  void draw() {
    drawBoard();
    displayMessage();
  }
  
  void mouseClicked() {
    println(">>> mouseClicked");
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
          message = "You are the champion, my friend!";
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
        message = "It's a draw! Let's stay friends...";
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
      message = "I win, you lose!";
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

  void displayMessage() {
    noStroke();
    fill(#FFFFFF);
    rect(95, 75, 700, 35);
    if (message != null) {
      fill(#217C7E);
      textSize(32);
      text(message, 100, 100);
    }
  }
  
  void drawBoard() {
    stroke(0);
    fill(BACKGROUND);
    rect (125, 115, 750, 600);
    int l = 650;
    for (int row = 0; row < Game.ROWS; row++, l -= 90) {
      int k = 200;
      for (int col = 0; col < Game.COLUMNS; col++, k += 100) {
        int cell = game.getCell(col, row);
        int colour = #F3EFE0;
        
        switch(cell) {
          case Game.RED:
            colour = #9A3334;
            break;
          case Game.BLUE:
            colour = #3399FF;
            break;
        }
        fill(colour);
        ellipse (k, l, 80, 80);
      }
    }
  }
  
  int getClickedColumn() {
    for (int i = 0; i < Game.COLUMNS; i++) {
      if(mouseX > (150 +(i)*(100)) && mouseX < (150 + (i+1)*(100)) && mouseY > 115 && mouseY < 715)
        return i;
    }
    return -1;
  } 
}
