class HomeScreen extends Screen {
  static final int BTN_WIDTH = 300;
  static final int BTN_HEIGHT = 50;
  static final int BTN_COLOR = #F3EFE0;
  
  Button pvp = new Button(10, 10, BTN_WIDTH, BTN_HEIGHT, BTN_COLOR, "Two Players Mode");
  Button pvc = new Button(10, 70, BTN_WIDTH, BTN_HEIGHT, BTN_COLOR, "One Player Mode");
  Button pups = new Button(10, 130, BTN_WIDTH, BTN_HEIGHT, BTN_COLOR, "Power Ups Mode");

  void draw() {
    pvp.draw();
    pvc.draw();
    pups.draw();
  }
  
  void mouseClicked() {
    if (pvp.isInside(mouseX, mouseY)) {
      clearScreen();
      screen = new PVPGameScreen();
    } else if (pvc.isInside(mouseX, mouseY)) {
      clearScreen();
      screen = new PVCGameScreen();
    } else if (pups.isInside(mouseX, mouseY)) {
      clearScreen();
      screen = new PVCGameScreen();
    }
  }

}
