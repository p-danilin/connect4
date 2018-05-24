class HomeScreen extends Screen {
  Button pvp = new Button(10, 10, "Two Players Mode");
  Button pvc = new Button(10, 70, "One Player Mode");
  Button pups = new Button(10, 130, "Power Ups Mode");

  void draw() {
    pvp.draw();
    pvc.draw();
    pups.draw();
  }
  
  void mouseClicked() {
    if (pvp.isInside(mouseX, mouseY)) {
      clearScreen();
      screen = new PVCGameScreen();
    } else if (pvc.isInside(mouseX, mouseY)) {
      clearScreen();
      screen = new PVCGameScreen();
    } else if (pups.isInside(mouseX, mouseY)) {
      clearScreen();
      screen = new PVCGameScreen();
    }
  }
  
  void clearScreen() {
    fill(#FFFFFF);
    rect(0, 0, width, height);
  }
}
