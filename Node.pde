final class Node {
    private int minMaxScore;
    private int depth;
    private int bestMove = -1;
    private Node[] moves;

     Node(int score, int currentColor, int depth) {
        this.minMaxScore = score * getScore(currentColor);
        this.depth = depth;
    }

     Node() {
    }

     int getMinMaxScore() {
        return minMaxScore;
    }

     int getDepth() {
        return depth;
    }

     int getBestMove() {
        return bestMove;
    }

     void calculateBestMove(Node[] moves, boolean isDraw, int branchDepth, int currentColor) { //<>//
        if (isDraw) {
            this.minMaxScore = 1;
            this.depth = branchDepth;
        } else {
            this.minMaxScore = -100 * getScore(currentColor);
            for (int col = 0; col < Game.COLUMNS; col++) {
                if (moves[col] != null) {
                    if (currentColor == Game.RED) {
                        if (this.minMaxScore > moves[col].getMinMaxScore()) {
                            this.minMaxScore = moves[col].getMinMaxScore();
                            this.depth = moves[col].getDepth();
                            this.bestMove = col;
                        } else if (this.minMaxScore == moves[col].getMinMaxScore()) {
                            if (this.depth > moves[col].getDepth()) {
                                this.depth = moves[col].getDepth();
                                this.bestMove = col;
                            }
                        }
                    } else {
                        if (this.minMaxScore < moves[col].getMinMaxScore()) {
                            this.minMaxScore = moves[col].getMinMaxScore();
                            this.depth = moves[col].getDepth();
                            this.bestMove = col;
                        } else if (this.minMaxScore == moves[col].getMinMaxScore()) {
                            if (this.depth > moves[col].getDepth()) {
                                this.depth = moves[col].getDepth();
                                this.bestMove = col;
                            }
                        }
                    }
                }
            }
        }
    }

     void setMoves(Node[] moves) {
        this.moves = moves;
    }

     Node[] getMoves() {
        return moves;
    }

     Node getMove(int col) {
        return moves[col];
    }
    
    private int getScore(int currentColor) {
      if (currentColor == Game.BLUE) {
        return 1;
      } else {
        return -1;
      }
    }
}
