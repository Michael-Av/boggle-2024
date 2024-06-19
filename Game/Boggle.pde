public class Boggle{
  char[][] board;
  int boardSize;
  
  public Boggle(int size){
    boardSize = size;
    board = new char[size][size];
  }
  
  
  public char getRandomLetter(){
    char[] alphabet = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                   'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
  
    float[] letterFreqs = {7.8, 2.0, 4.0, 3.8, 11.0, 1.4, 3.0, 2.3, 8.6, 0.21, 0.97, 5.3, 2.7, 7.2, 6.1, 2.8, 0.19, 7.3, 8.7, 6.7, 3.3, 1.0, 0.91, 0.27};
    
    float whichLetter = random(100);
    float currLetter = 0;
    for (int k = 0; k < alphabet.length; k++){
      if (whichLetter > currLetter && whichLetter < currLetter + letterFreqs[k]){
        return alphabet[k];
      }
      currLetter += letterFreqs[k];
    }
    return '!';
  }
  
  public void initializeBoard(){
    for (int i = 0; i < boardSize; i++){
      for (int j = 0; j < boardSize; j++){
        board[i][j] = getRandomLetter();
      }
    }
  }
            
  
}
