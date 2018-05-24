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
    
     Game() {}
    
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
    
     boolean isColumnFull(int col) {
        return emptyTops[col] == ROWS;
    }

     void takeCoinBack(int col) {
        cells[col][emptyTops[col] - 1] = EMPTY;
        emptyTops[col]--;
    }

    /**
     * dropCoin modifies the game board by dropping a coin to a column
     * THis assumes that the column is not full
     * @param col
     * @return true if colour wins after the move
     */
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

    int getCell(int col, int row) {
        return cells[col][row];
    }
}
