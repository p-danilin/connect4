boolean dropC4 (int column, int colour)
{
  game.cells[column][game.emptyTops[column]-1] = 0;
  return game.dropCoin(column, colour);
}
