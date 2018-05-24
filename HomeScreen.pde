class HomeScreen extends Screen {
  Button pvp = new Button(10, 10, "Two Players Mode");
  Button pvc = new Button(10, 70, "One Player Mode");
  Button pups = new Button(10, 130, "Power Ups Mode");

  void draw() {
    pvp.draw();
    pvc.draw();
    pups.draw();
  }
}
