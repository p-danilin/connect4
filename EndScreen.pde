/*** EndScreen **************************************
 * Purpose: displays the end screen, winner and C4     *
 * Returns: none                                       *
 ******************************************************/
class EndScreen extends GameScreen {

  EndScreen(Game game, String message, int finalGameStatus) {
    this.game = game;
    this.message = message;
    this.finalGameStatus = finalGameStatus;
  }

  void draw() {
    displayMessage();
    home.draw();
    drawBoard();
    if (finalGameStatus == 0) {
      image(bothC4, 350, 300);
    } else if (finalGameStatus == 1) {
      image(redC4, 350, 300);
    } else if (finalGameStatus == 2) {
      image(blueC4, 350, 300);
    }
  }

  void mouseClicked() {
    checkHomeButton();
  }
}
