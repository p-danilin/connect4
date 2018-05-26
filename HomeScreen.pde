//homescreen makes the homescreen, and has makes all the buttons for the game
class HomeScreen extends Screen {
  static final int BTN_WIDTH = 300;
  static final int BTN_HEIGHT = 50;
  static final int BTN_COLOR = #F3EFE0;
  
  Button pvp = new Button(350, 500, BTN_WIDTH, BTN_HEIGHT, BTN_COLOR, "Two Players Mode");
  Button pvc = new Button(350, 570, BTN_WIDTH, BTN_HEIGHT, BTN_COLOR, "One Player Mode");
  Button pups = new Button(350, 640, BTN_WIDTH, BTN_HEIGHT, BTN_COLOR, "Power Ups Mode");
  Button info = new Button(350, 710, BTN_WIDTH, BTN_HEIGHT, BTN_COLOR, "Game Info");
  
  void draw() {
    pvp.draw();
    pvc.draw();
    pups.draw();
    info.draw();
    image(bothC4, 350, 150);
  }
  
  void mouseClicked() {
    if (pvp.isInside()) {
      clearScreen();
      screen = new PVPGameScreen();
    } else if (pvc.isInside()) {
      clearScreen();
      screen = new PVCGameScreen();
    } else if (pups.isInside()) {
      clearScreen();
      screen = new PupsGameScreen();
    } else if (info.isInside()) {
      clearScreen();
      screen = new InfoScreen();
    }
  }

}
