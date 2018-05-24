Game game = new Game();

Screen screen;
MinMax minMax = new MinMax();

void setup() {
  background (255);
  size(1000, 850);


  screen = new GameScreen(game);
}

void draw() {
  screen.draw();
}

void mouseReleased() {
  println("mouse clicked: " + mouseX + ", " + mouseY);
  screen.mouseClicked();
}

void think() {
  screen.think();
}
