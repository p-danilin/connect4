//Class game, shows how the game should be played
class Game {
  static final int EMPTY = 0;
  static final int RED = 1;
  static final int BLUE = 2;

  static final int COLUMNS = 7;
  static final int LAST_COLUMN = COLUMNS - 1;
  static final int ROWS = 6;
  static final int LAST_ROW = ROWS - 1;
  static final int CELLS_TO_WIN = 4;

  /**
   * Board:
   *    rows:
   *        5 []
   *        4 []  
   *           ......
   *        1 []
   *        0 [] [] [] ..... []
   * columns: 0  1  2        6
   */
  private int[][] cells = new int[COLUMNS][ROWS];
  private int[] emptyTops = new int[COLUMNS];

  Game() {
  }

  Game(Game game) {
    for (int c = 0; c < Game.COLUMNS; c++) {
      for (int r = 0; r < Game.ROWS; r++) {
        cells[c][r] = game.cells[c][r];
      }
    }
    for (int c = 0; c < Game.COLUMNS; c++) {
      emptyTops[c] = game.emptyTops[c];
    }
  }
  /*** isColumnFull ***********************************
   * Purpose: checks if a column is full                 *
   * Parameters:col - the column                         *
   * Returns: boolean                                    *
   ******************************************************/
  boolean isColumnFull(int col) {
    return emptyTops[col] == ROWS;
  }
  /*** takeCoinBack **************************************
   * Purpose: takes coin out if it was dropped somewhere *
   * Parameters: col - the column                        *
   * Returns: none                                       *
   ******************************************************/
  void takeCoinBack(int col) {
    cells[col][emptyTops[col] - 1] = EMPTY;
    emptyTops[col]--;
  }

  /**
   * dropCoin modifies the game board by dropping a coin to a column
   * THis assumes that the column is not full
   * param col
   * return true if colour wins after the move
   */
  /*** dropCoin ******************************************************
   * Purpose:  modifies the game board by dropping a coin to a column
   *            then checks for win or not                *
   * Parameters: col - column                             *
   *              colour - the colour                     *
   * Returns: boolean                                     *
   ******************************************************/
  boolean dropCoin(int col, int colour) {
    int row = emptyTops[col];
    cells[col][row] = colour;
    emptyTops[col]++;

    // check horizontally
    // go from the new cell to the left
    int hCount = 0;
    if (col > 0) {
      // can go left
      for (int cc = col - 1; cc >= 0 && hCount < CELLS_TO_WIN - 1; cc--) {
        if (getCell(cc, row) == colour) {
          hCount++;
        } else {
          break;
        }
      }
      if (hCount >= CELLS_TO_WIN - 1) {
        return true;
      }
    }
    // gro from the new cell to the right
    if (col < LAST_COLUMN) {
      // can go right
      for (int cc = col + 1; cc < COLUMNS && hCount < CELLS_TO_WIN - 1; cc++) {
        if (getCell(cc, row) == colour) {
          hCount++;
        } else {
          break;
        }
      }
    }
    if (hCount >= CELLS_TO_WIN - 1) {
      return true;
    }


    // check vertically
    if (row > CELLS_TO_WIN - 2) {
      // can go down
      int vCount = 0;
      for (int rr = row - 1; rr >= 0 && vCount < 3; rr--) {
        if (getCell(col, rr) == colour) {
          vCount++;
        } else {
          break;
        }
      }
      if (vCount >= CELLS_TO_WIN - 1) {
        return true;
      }
    }

    // check top left to bottom right
    int tlCount = 0;
    // got down
    if (col < LAST_COLUMN && row > 0) {
      for (int cc = col + 1, rr = row - 1; cc < COLUMNS && rr >= 0 && tlCount < 3; cc++, rr--) {
        if (getCell(cc, rr) == colour) {
          tlCount++;
        } else {
          break;
        }
      }
      if (tlCount >= CELLS_TO_WIN - 1) {
        return true;
      }
    }
    // up
    if (col > 0 && row < LAST_ROW) {
      for (int cc = col - 1, rr = row + 1; cc >= 0 && rr < ROWS && tlCount < 3; cc--, rr++) {
        if (getCell(cc, rr) == colour) {
          tlCount++;
        } else {
          break;
        }
      }
    }
    if (tlCount >= CELLS_TO_WIN - 1) {
      return true;
    }

    // check top right to botoom left
    int trCount = 0;
    // got down
    if (col > 0 && row > 0) {
      for (int cc = col - 1, rr = row - 1; cc >= 0 && rr >= 0 && trCount < 3; cc--, rr--) {
        if (getCell(cc, rr) == colour) {
          trCount++;
        } else {
          break;
        }
      }
      if (trCount >= CELLS_TO_WIN - 1) {
        return true;
      }
    }
    // up
    if (col < LAST_COLUMN && row < LAST_ROW) {
      for (int cc = col + 1, rr = row + 1; cc < COLUMNS && rr < ROWS && trCount < 3; cc++, rr++) {
        if (getCell(cc, rr) == colour) {
          trCount++;
        } else {
          break;
        }
      }
    }
    if (trCount >= CELLS_TO_WIN - 1) {
      return true;
    }

    return false;
  }
  /*** dropC4 ********************************************
   * Purpose: drops the powerup c4, and returns wether or*not there has been a win*
   * Parameters: col - the column                        *
   * Returns: boolean                                    *
   ******************************************************/
  boolean dropC4(int col) {
    int c4Row = emptyTops[col];

    removeC4Column(col, c4Row);

    boolean isWin = false;
    if (col - 1 >= 0) {
      isWin = isWin || removeC4Column(col - 1, c4Row);
    }

    if (col + 1 < Game.COLUMNS) {
      isWin = isWin || removeC4Column(col + 1, c4Row);
    }

    return isWin;
  }

  boolean removeC4Column(int col, int row) {
    if (row - 1 >= 0) {
      cells[col][row-1] = EMPTY;
    }
    cells[col][row] = EMPTY;
    if (row + 1 < Game.ROWS) {
      cells[col][row + 1] = EMPTY;
    }

    // drop cells starting from row + 2 and up to min (0, row - 1);
    boolean isWin = false;
    emptyTops[col] = min(emptyTops[col], max(0, row - 1));
    for (int rr = row + 2; rr < Game.ROWS && cells[col][rr] != EMPTY; rr++) {
      isWin = isWin || dropCoin(col, cells[col][rr]);
      cells[col][rr] = EMPTY;
    }
    return isWin;
  }
  /*** dropBedBugs **************************************
   * Purpose: drops the bedbug powerup, making the bottom row equal to 0, and the rest of the coins drop down *
   * Parameters: col - the column                        *
   *              colour - the colour                    *
   * Returns: none                                       *
   ******************************************************/
  boolean dropBedBugs(int bbCol, int colour) {
    println("dropping BedBugs");
    for (int cc = 0; cc < COLUMNS; cc++) {
      if (emptyTops[cc] > 0) {
        for (int row = 0; row < emptyTops[cc] - 1; row++) {
          cells[cc][row] = cells[cc][row+1];
        }
        cells[cc][emptyTops[cc] - 1] = 0; 
        emptyTops[cc] = emptyTops[cc] - 1;
      }
    }
    return dropCoin(bbCol, colour);
  }

   /*** getCell ******************************************
   * Purpose: returns the cell you ask for               *
   * Parameters: col - the column                        *
   *              row - the row                          *
   * Returns: int, the cell you ask for                  *
   ******************************************************/
  int getCell(int col, int row) {
    return cells[col][row];
  }
}
