//Infoscreen gives the user information on the game
class InfoScreen extends Screen {
  Button home = new Button(325, 500, 350, 50, #F3EFE0, "Back to Home Screen");


  void draw() {
    textSize(32);
    text("Two player game.", 10, 100);
    text("One player game.", 10, 200);
    text("Power up game.", 10, 300);
    textSize(19);
    text("Player 1 plays with red coins, Player 2 with blue. You take turns dropping coins into a 7 x 6 board.", 250, 100);
    text("Game ends when 4 coins in a row, column, or diagonal of the same colour have been connected.", 250, 130);
    text("Classic game mode, however you are facing a challenging computer. He will think harder and harder", 250, 200);
    text("as the game progresses. Try to beat him early, where he might just give up!", 250, 230);
    text("Twist on the classic game mode, where power ups spawn randomly. The two power ups you will", 250, 300);
    text("experience are the ants, and the C4! The ants will infest the bottom layer when dropped, making", 250, 330);
    text("the entire bottom layer disappear. The C4 will explode, affecting every cell touching it.", 250, 360);
    home.draw();
  }

  void mouseClicked() {
    if (home.isInside()) {
      clearScreen();
      screen = new HomeScreen();
    }
  }
}
