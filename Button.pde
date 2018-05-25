class Button {
  int x;
  int y;
  int h;
  int w;
  String text;
  int cc;
  
  Button(int x, int y, int w, int h, int cc, String text) {
    this.x = x;
    this.y = y;
    this.h = h;
    this.w = w;
    this.cc = cc;
    this.text = text;
  }
  
  void draw() {
    fill(cc);
    stroke(0);
    rect(x, y, w, h);
    textSize(32);
    fill(0);
    text(text, x+5, y+35);
  }
  
  boolean isInside(int mx, int my) {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      return true;
    } else { 
      return false;
    }
  }
}
