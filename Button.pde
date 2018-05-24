class Button {
  int x;
  int y;
  String text;
  static final int WIDTH = 300;
  static final int HEIGHT = 50;
  
  Button(int x, int y, String text) {
    this.x = x;
    this.y = y;
    this.text = text;
  }
  
  void draw() {
    fill(#F3EFE0);
    stroke(0);
    rect(x, y, WIDTH, HEIGHT);
    textSize(32);
    fill(0);
    text(text, x+5, y+35);
  }
  
  boolean isInside(int mx, int my) {
    if (mouseX > x && mouseX < x + WIDTH && mouseY > y && mouseY < y + HEIGHT) {
      return true;
    } else { 
      return false;
    }
  }
}
