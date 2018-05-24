class MinMax {
  Node calculateTree(Game game, int currentColor, int depth, int maxDepth) {
    Node[] moves = new Node[Game.COLUMNS];
    boolean isDraw = true;
    for (int col = 0; col < Game.COLUMNS; col++) {
      if (!game.isColumnFull(col)) {
        isDraw = false;
        if (game.dropCoin(col, currentColor)) {
          moves[col] = new Node(10, currentColor, depth + 1);
        } else {
          if (depth < maxDepth) {
            moves[col] = calculateTree(game, changeColor(currentColor), depth + 1, maxDepth);
          } else {
            moves[col] = new Node(0, currentColor, depth + 1);
          }
        }
        game.takeCoinBack(col);
      }
    }
    Node node = new Node();
    node.calculateBestMove(moves, isDraw, depth, currentColor);
    if (depth == 0) {
      node.setMoves(moves);
    }
    return node;
  }

  private int changeColor(int currentColor) {
    if (currentColor == Game.BLUE) {
      return Game.RED;
    } else {
      return Game.BLUE;
    }
  }  
}
