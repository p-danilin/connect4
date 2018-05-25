class EndScreen extends GameScreen {
  
  EndScreen(Game game, String message) {
    this.game = game;
    this.message = message;
  }
  
  void draw() {
    displayMessage();
    home.draw();
    drawBoard();
  }

  void mouseClicked() {
    checkHomeButton();
  }
}
