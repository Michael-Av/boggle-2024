public class Display{
  Boggle b;
  char[][] board;
  int boardSize;
  float squareSize;
  float x0, y0;
  int textSize;
  
  public Display(Boggle b){
    this.b = b;
    board = b.board;
    boardSize = b.boardSize;
    squareSize = (width / (2.5 * b.boardSize) + height / (2.5 * b.boardSize)) / 2;
    x0 = width / (2.5 * b.boardSize);
    y0 = width / (2.5 * b.boardSize);
    textSize = 20;
  }
  
  public float displayGame(String word, boolean isGameOver){
    background(255);
    drawBoard();
    displayWord(word);
    float x = displayWords(isGameOver);
    displayTime();
    return x;
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
  
  public float displayWords(boolean isGameOver){
    ArrayList<String> words = b.words;
    textSize(textSize);
    textAlign(LEFT);
    boolean strikeThrough = false;
    int currWord = 0;
    float x = x0 + squareSize * boardSize;
    
    while (currWord < words.size()){
      float longestWord = 0;
      float y = textSize+5;//y0 - squareSize;
      while (currWord < words.size() && y < height){
        if (textWidth(words.get(currWord)) > longestWord){
          longestWord = textWidth(words.get(currWord));
        }
        if (isGameOver)
          strikeThrough = ! b.uniqueWords[currWord];
        displayText(words.get(currWord), strikeThrough, x, y, textSize);
        y += (textSize+5);
        currWord++;
      }
      x += longestWord + 10;
    }
    textAlign(CENTER);
    return x;
  }
  
  public void displayText(String display, boolean toStrikeThrough, float xStart, float yStart, int fontSize){
    text(display,xStart,yStart);  
    if (toStrikeThrough) {
      line(xStart-3,yStart-fontSize/2+fontSize/8,xStart+textWidth(display)+3,yStart-fontSize/2+fontSize/8);
    }
  }
  
  public void displayWord(String word){
    textSize(squareSize / 1.5);
    float y = bToPCoords(boardSize - 1, 0)[1];
    y += 2 * squareSize;
    float halfWidth = (boardSize - 1) * squareSize / 2;
    float x = x0 + halfWidth;
    
    text(word, x, y);
  }
  
  public void displayTime() {
    textSize(60);
    text(convertToMMSS(b.time), 1300, 70);
  }
  
  public String convertToMMSS(int time) {
    int mins = time / 60;
    int secs = time - time / 60 * 60;
    String result = mins + ":";
    if (secs == 0) {
      result = result + secs + 0;
    } else if (secs < 10) {
      result = result + 0 + secs;
    } else {
      result += secs;
    }
    return result;
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
  
  public void displayRobotWords(ArrayList<ArrayList<String>> robotsWords, float xToStart){
    textSize(textSize);
    textAlign(LEFT);
    fill(255, 0, 0);
    float x = xToStart;
    boolean strikeThrough = false;
    
    for (int i = 0; i < robotsWords.size(); i++){
      ArrayList<String> words = robotsWords.get(i);
      int currWord = 0;
      x += 10;
      while (currWord < words.size()){
        float longestWord = 0;
        float y = textSize+5;//y0 - squareSize;
        while (currWord < words.size() && y < height){
          if (textWidth(words.get(currWord)) > longestWord){
            longestWord = textWidth(words.get(currWord));
          }
          strikeThrough = ! b.robots[i].uniqueWords[currWord];
          displayText(words.get(currWord), strikeThrough, x, y, textSize);
          y += (textSize+5);
          currWord++;
        }
        x += longestWord + 10;
      }
    }
    textAlign(CENTER);
    fill(0);
  }
  
  public void displayScores(int[] scores){
    textAlign(LEFT);
    textSize(30);
    float y = y0 + squareSize * boardSize;
    
    text("Player's score: " + scores[0], x0, y);
    for (int i = 1; i < scores.length; i++){
      y += 40;
      int score = scores[i];
      text("Robot " + i + "'s score: " + score, x0, y);
    }
    textAlign(CENTER);
  }
}
