class GameScreen extends Screen {
  static final int BACKGROUND = #F3EFE0;
  static final int TURQ_COL = #217C7E;
  static final String PLAYER_MOVE = "Please make your move";
  
  Button home = new Button(750, 60, 100, 50, TURQ_COL, "Home");
    
  Game game;
  int moveNum = 1;
  String message = null;
  
  void displayMessage() {
    noStroke();
    fill(#FFFFFF);
    rect(95, 75, 700, 35);
    if (message != null) {
      fill(TURQ_COL);
      textSize(32);
      text(message, 100, 100);
    }
    home.draw();
  }
  
  void drawBoard() {
    stroke(0);
    fill(BACKGROUND);
    rect (125, 115, 750, 600);
    int l = 650;
    for (int row = 0; row < Game.ROWS; row++, l -= 90) {
      int k = 200;
      for (int col = 0; col < Game.COLUMNS; col++, k += 100) {
        int cell = game.getCell(col, row);
        int colour = #F3EFE0;
        
        switch(cell) {
          case Game.RED:
            colour = #9A3334;
            break;
          case Game.BLUE:
            colour = #3399FF;
            break;
        }
        fill(colour);
        ellipse (k, l, 80, 80);
      }
    }
  }
  
  int getClickedColumn() {
    for (int i = 0; i < Game.COLUMNS; i++) {
      if(mouseX > (150 +(i)*(100)) && mouseX < (150 + (i+1)*(100)) && mouseY > 115 && mouseY < 715)
        return i;
    }
    return -1;
  }
    
    boolean checkHomeButton() {
      if (home.isInside(mouseX, mouseY)) {
        clearScreen();
        screen = new HomeScreen();
        return true;
      } else {
        return false;
      }
    }  
}
