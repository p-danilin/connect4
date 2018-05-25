class PVPGameScreen extends GameScreen {
  static final String RED_TURN = "Player 1's turn";
  static final String BLUE_TURN = "Player 2's turn";

  boolean isThinking = false;
  int currentColor = Game.RED;

  PVPGameScreen() {
    this.game = new Game();
    message = RED_TURN;
  }

  void draw() {
    drawBoard();
    displayMessage();
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
        if (game.dropCoin(col, currentColor)) {
          screen = new EndScreen(game, winMessage());
          return;
        }
        if (checkForDraw()) {
          screen = new EndScreen(game, "It is a draw!");
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
