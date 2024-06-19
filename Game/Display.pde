public class Display{
  Boggle b;
  char[][] board;
  int boardSize;
  
  public Display(Boggle b){
    this.b = b;
    board = b.board;
    boardSize = b.boardSize;
  }
  
  public void drawBoard(){
    float squareSize = (width / 12 + height / 12) / 2;
    fill(230, 230, 230);
    
    int x = 11 * width / 12;
    stroke(0, 0, 0);
    
    for (int i = 0; i < boardSize; i++){
      int y = height / 12;
      for (int j = 0; j < boardSize; j++){
        char currChar = board[i][j];
        square(x, y, squareSize);
        y += squareSize;
      }
      x -= squareSize;
    }
  }
        
  
  
}
