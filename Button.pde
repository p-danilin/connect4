/*** Button ******************************************
 * Purpose: makes buttons following parameters        *
 * Parameters: x - top left x coordinate              *
 *             y - top left y coordinate              *
 *             w - bottom right x coordinate          *
 *             h - bottom right y coodinate           *
 *             cc - colour of the box                 *
 * Returns: none                                      *
 ******************************************************/
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
    stroke(GameScreen.TURQ_COL);
    rect(x, y, w, h);
    textSize(32);
    fill(GameScreen.TURQ_COL);
    text(text, x+5, y+35);
  }
  /*** isInside ******************************************
   * Purpose: responds wether mouse is in the button or  *
   *          not                                        *
   * Returns: boolean                                    *
   ******************************************************/
  boolean isInside() {
    if (mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      return true;
    } else { 
      return false;
    }
  }
}
