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
  
  //testPUPS();
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

void printGame(Game game) {
    for (int row = Game.LAST_ROW; row >= 0; row--) {
        for (int cc = 0; cc < Game.COLUMNS; cc++) {
            int cell = game.getCell(cc, row);
            switch (cell) {
                case Game.RED:
                    print("X|");
                    break;
                case Game.BLUE:
                    print("O|");
                    break;
                case Game.EMPTY:
                    print(" |");
                    break;
                default:
                    print("?|");
                    break;
            }
        }
        println("\n--------------");
    }
    println("0 1 2 3 4 5 6");
    println("tops:");
    for (int cc = 0; cc < Game.COLUMNS; cc++) {
      print("" + game.emptyTops[cc] + " ");
    }
    println("");
}

void testPUPS() {
  Game g = new Game();
  g.dropCoin(2, Game.BLUE);
  g.dropCoin(2, Game.RED);
  g.dropCoin(2, Game.BLUE);
  g.dropCoin(2, Game.RED);
  g.dropCoin(2, Game.BLUE);
  g.dropCoin(2, Game.RED);
  
  g.dropCoin(3, Game.RED);
  g.dropCoin(3, Game.BLUE);
  g.dropCoin(3, Game.RED);
  g.dropCoin(3, Game.BLUE);

  g.dropCoin(4, Game.BLUE);

  printGame(g);

  g.dropC4(3);
  
  println("After C4 at 3:");
  
  printGame(g);
  
  if (g.emptyTops[4] != 1) {
    println("Wrong emptyTops[4] = " + g.emptyTops[4]);
    //throw new Error("error in c4!");
  }
}
