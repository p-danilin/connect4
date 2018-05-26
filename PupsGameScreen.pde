class PupsGameScreen extends GameScreen {
  static final String RED_TURN = "Player 1's turn";
  static final String BLUE_TURN = "Player 2's turn";

  static final int C4_PUP = 1;
  static final int BEDBUGS_PUP = 2;
  static final float PUP_PROBABILITY = 10; // one in 20

  boolean isThinking = false;
  int currentColor = Game.RED;
  int currentPUP = 0;

  PupsGameScreen() {
    this.game = new Game();
    message = RED_TURN;
  }

  void draw() {
    clearScreen();
    drawBoard();
    displayMessage();
    if (currentColor == game.RED) {
      image(redCoin, mouseX-50, mouseY-50);
    } else if (currentColor == game.BLUE) {
      image(blueCoin, mouseX-50, mouseY-50);
    }
    if(currentPUP == 1){
      image(bothC4, mouseX-50, mouseY-50, 130, 120);
    } else if (currentPUP == 2) {
      image(ant, mouseX-50, mouseY-50, 100, 100);
    }
  }

  void mouseClicked() {
    if (checkHomeButton()) {
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
        if (currentPUP == C4_PUP) {
          println("c4 move");
          if (game.dropC4(col)) {
            screen = new EndScreen(game, winMessage(), currentColor);
            return;
          }
        } else if (currentPUP == BEDBUGS_PUP) {
          println("bedbugs move");
          if (game.dropBedBugs(col, currentColor)) {
            screen = new EndScreen(game, winMessage(), currentColor);
            return;
          }
        } else if (game.dropCoin(col, currentColor)) {
          screen = new EndScreen(game, winMessage(), currentColor);
          return;
        }
        if (checkForDraw()) {
          screen = new EndScreen(game, "It is a draw!", Game.EMPTY);
          return;
        }
        moveNum++;
      }

      if (currentColor == Game.RED) {
        currentColor = Game.BLUE;
        message = BLUE_TURN;
      } else {
        currentColor = Game.RED;
        message = RED_TURN;
      }
    }
    currentPUP = (int) random(PUP_PROBABILITY);
    println("random pup: " + currentPUP);
    if (currentPUP != C4_PUP && currentPUP != BEDBUGS_PUP) {
      currentPUP = 0;
    }

  }


  String winMessage() {
    if (currentColor == Game.RED) {
      return "Player 1 won!";
    } else {
      return "Player 2 won!";
    }
  }

  boolean checkForDraw() {
    for (int i = 0; i<Game.COLUMNS; i++) {
      if (!game.isColumnFull(i)) {
        return false;
      }
    }
    return true;
  }
}
