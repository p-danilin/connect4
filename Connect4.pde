Screen screen;
MinMax minMax = new MinMax();

void setup() {
  background (255);
  size(1000, 850);
  
  screen = new HomeScreen();
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

  
void clearScreen() {
  fill(#FFFFFF);
  rect(0, 0, width, height);
}
