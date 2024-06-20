public class Display{
  Boggle b;
  char[][] board;
  int boardSize;
  float squareSize;
  float x0, y0;
  
  public Display(Boggle b){
    this.b = b;
    board = b.board;
    boardSize = b.boardSize;
    squareSize = (width / (2.5 * b.boardSize) + height / (2.5 * b.boardSize)) / 2;
    x0 = width / (2.5 * b.boardSize);
    y0 = width / (2.5 * b.boardSize);
  }
  
  public void displayGame(String word){
    background(255);
    drawBoard();
    displayWords();
    displayWord(word);
  }
  
  public float[] bToPCoords(int row, int col){
    float x0 = width / 12;
    float y0 = height / 12;
    
    float[] coords = {x0 + squareSize * col, y0 + squareSize * row};
    return coords;
  }
  
  public int[] pToBCoords(float x, float y){
    
    float thisY = y0 - squareSize / 2;
    float nextY = thisY + squareSize;
    
    for (int i = 0; i < boardSize; i++){
      float thisX = x0 - squareSize / 2;
      float nextX = thisX + squareSize;
      
      if (y > thisY && y < nextY){
        for (int j = 0; j < boardSize; j++){
          if (x > thisX && x < nextX){
            return (new int[]{i, j});
          }
          thisX = nextX;
          nextX = thisX + squareSize;
        }
      }
      
      thisY = nextY;
      nextY = thisY + squareSize;
    }
    return null;
  }
  
  public void displayWords(){
    ArrayList<String> words = b.words;
    textSize(20);
    textAlign(LEFT);
    int currWord = 0;
    float x = x0 + squareSize * boardSize;
    while (currWord < words.size()){
      float longestWord = 0;
      float y = y0 - squareSize;
      while (currWord < words.size() && y < height){
        if (textWidth(words.get(currWord)) > longestWord){
          longestWord = textWidth(words.get(currWord));
        }
        text(words.get(currWord), x, y);
        y += 25;
        currWord++;
      }
      x += longestWord + 10;
    }
    textAlign(CENTER);
  }
  
  public void displayWord(String word){
    textSize(squareSize / 1.5);
    float y = bToPCoords(boardSize - 1, 0)[1];
    y += 2 * squareSize;
    float halfWidth = (boardSize - 1) * squareSize / 2;
    float x = x0 + halfWidth;
    
    text(word, x, y);
  }
  
  public void drawBoard(){
    fill(230);
    stroke(0);
    textSize(squareSize / 1.5);
    
    for (int i = 0; i < boardSize; i++){
      for (int j = 0; j < boardSize; j++){
        float[] coords = bToPCoords(i, j);
        rect(coords[0], coords[1], squareSize, squareSize);
      }
    }
    
    fill(0);
    
    for (int i = 0; i < boardSize; i++){
      for (int j = 0; j < boardSize; j++){
        float[] coords = bToPCoords(i, j);
        char currChar = board[i][j];
        text(currChar + "", coords[0], coords[1] + squareSize / 4);
      }
    }
    
  }
        
  
  
}
