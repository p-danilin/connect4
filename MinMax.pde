//MinMax goes through each move to a certain depth, checking for any possible wins for the computer, or losses that it can prevent. It also prioritizes any drawable moves over losing ones
class MinMax {
  static final int WIN = 10;
  
  Node calculateTree(Game game, int currentColor, int depth, int maxDepth) {
    Node[] moves = new Node[Game.COLUMNS];
    boolean isDraw = true;
    boolean stop = false;
    for (int col = 0; col < Game.COLUMNS; col++) {
      if (!game.isColumnFull(col)) {
        isDraw = false;
        if (game.dropCoin(col, currentColor)) {
          moves[col] = new Node(WIN, currentColor, depth + 1);
        } else {
          if (depth < maxDepth) {
            moves[col] = calculateTree(game, changeColor(currentColor), depth + 1, maxDepth);
            if (moves[col].getMinMaxScore() == WIN * moves[col].getScore(currentColor)) {
              stop = true;
            }
          } else {
            moves[col] = new Node(0, currentColor, depth + 1);
          }
        }
        game.takeCoinBack(col);
        if (stop) {
          break;
        }
      }
    }
    Node node = new Node();
    node.calculateBestMove(moves, isDraw, depth, currentColor);
    if (depth == 0) {
      node.setMoves(moves);
    }
    return node;
  }
  //changes colour of the coin
  private int changeColor(int currentColor) {
    if (currentColor == Game.BLUE) {
      return Game.RED;
    } else {
      return Game.BLUE;
    }
  }  
}
