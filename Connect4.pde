PImage redCoin;
PImage blueCoin;
PImage redC4;
PImage blueC4;
PImage bothC4;
PImage ant;
PFont font;
Screen screen;
MinMax minMax = new MinMax();

void setup() {
  background (255);
  size(1000, 850);

  screen = new HomeScreen();


  redCoin = loadImage("redCoin.png");
  blueCoin = loadImage("blueCoin.png");
  redC4 = loadImage("redC4.png");
  blueC4 = loadImage("blueC4.png");
  bothC4 = loadImage("bothC4.png");
  ant = loadImage("ant.png");
  font = loadFont("PoorRichard-Regular-32.vlw");
  textFont(font, 32);
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

/*** clearScreen **************************************
 * Purpose: clears the screen, making it white         *
 * Returns: none                                       *
 ******************************************************/
void clearScreen() {
  fill(#FFFFFF);
  rect(0, 0, width, height);
}
