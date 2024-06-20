public class Boggle{
  char[][] board;
  char[][] biggleBoard;
  int boardSize;
  Word currWord;
  ArrayList<String> words;
  
  public Boggle(int size){
    boardSize = size;
    board = new char[size][size];
    biggleBoard = new char[size + 2][size + 2];
    currWord = new Word();
    words = new ArrayList<String>();
  }
  
  public void setupGame(){
    initializeBoard();
    initializeBiggleBoard();
  }
  
  public boolean dictContains(String word){
    try {
      File f = new File(sketchPath("words.txt"));
      Scanner sc = new Scanner(f);
      int n = 0;
      while (n < 100){
        println(sc.nextLine());
        n++;
      }
      return true;
    } catch (FileNotFoundException f){
      println("File not found :(" + f);
      return false;
    }
  }
    
  
  public String addLetter(char letter){
    int result = currWord.addLetter(letter);
    if (result == 3){ // if the word is completed
      addWord(currWord.getWord());
    }
    return currWord.getWord();
  }
      
  
  public boolean addWord(String word){
    word = word.toUpperCase();
    if (checkWord(word) && dictContains(word)) {
      words.add(word);
      currWord = new Word();
      System.out.println("word [" + word + "] found");
      return true;
    }
    currWord = new Word();
    System.out.println("word [" + word + "] not found");
    return false;
  }
  
  public boolean checkWord(String word){
    if (word.length() == 0) {
      return false;
    }
    ArrayList<int[]> firstCoords = new ArrayList<>();
    // finds all coordinates that match the first letter and stores them in firstCoords
    for (int i = 0; i < biggleBoard.length; i++) {
      for (int j = 0; j < biggleBoard.length; j++) {
        if (biggleBoard[i][j] == word.charAt(0)) {
          firstCoords.add(new int[] {i, j});
        }
      }
    }
    // calls checkWordHelper for all potential starting locations of the word
    for (int i = 0; i < firstCoords.size(); i++) {
      ArrayList<int[]> usedCoords = new ArrayList<>();
      usedCoords.add(firstCoords.get(i));
      if (checkWordHelper(word.substring(1), usedCoords, firstCoords.get(i))) {
        return true;
      }
    }
    return false;
  }
  
  public boolean checkWordHelper(String word, ArrayList<int[]> usedCoords, int[] currentCoords) {
    // returns true if all letters in the word have been found in order
    if (word.length() <= 0) {
      System.out.print("<");
      for (int i = 0; i < usedCoords.size(); i++) {
        System.out.print(Arrays.toString(usedCoords.get(i)));
        if (i < usedCoords.size() - 1) {
          System.out.print(", ");
        }
      }
      System.out.println(">"); // <-- shows the coords of where the word was found
      return true;
    }
    // checks 8 letters surrounding currentCoords for potential coords of next letter
    // and stores those coords in potentialNextCoords
    ArrayList<int[]> potentialNextCoords = new ArrayList<>();
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int x = currentCoords[0] + i;
        int y = currentCoords[1] + j;
        if (coordAlreadyUsed(new int[] {x, y}, usedCoords)) {
          //System.out.println("coords [" + x + ", " + y + "] already used");
          continue;
        }
        if (biggleBoard[x][y] == word.charAt(0)) {
          potentialNextCoords.add(new int[] {x,y});
        }
      }
    }
    // if no potential next coords are found, returns false
    if (potentialNextCoords.size() == 0) {
      return false;
    }
    // recursively calls checkWordHelper for all potential next coords
    for (int i = 0; i < potentialNextCoords.size(); i++) {
      usedCoords.add(potentialNextCoords.get(i));
      if (checkWordHelper(word.substring(1), usedCoords, potentialNextCoords.get(i))) {
        return true;
      }
      usedCoords.remove(usedCoords.size() - 1);
    }
    return false;
  }
  
  // checks if int[] coords is in ArrayList<int[]> usedCoords
  public boolean coordAlreadyUsed(int[] coords, ArrayList<int[]> usedCoords) {
    //System.out.println("coords being tested: " + Arrays.toString(coords));
    for (int i = 0; i < usedCoords.size(); i++) {
      //System.out.println("coords being tested against: " + Arrays.toString(usedCoords.get(i)));
      if (coords[0] == usedCoords.get(i)[0] && coords[1] == usedCoords.get(i)[1]) {
        //System.out.println("true returned");
        return true;
      }
    }
    //System.out.println("false returned");
    return false;
  }
      
  public char getRandomLetter(){
    char[] alphabet = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                   'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
  
    float[] letterFreqs = {7.8, 2.0, 4.0, 3.8, 11.0, 1.4, 3.0, 2.3, 8.6, 0.21, 0.97, 5.3, 2.7, 7.2, 6.1, 2.8, 0.19, 7.3, 8.7, 6.7, 3.3, 1.0, 0.91, 0.27, 1.6, 0.44};
    
    float whichLetter = random(100);
    float currLetter = 0;
    for (int k = 0; k < alphabet.length; k++){
      if (whichLetter > currLetter && whichLetter < currLetter + letterFreqs[k]){
        return alphabet[k];
      }
      currLetter += letterFreqs[k];
    }
    return 'E';
  }
  
  public void initializeBoard(){
    for (int i = 0; i < boardSize; i++){
      for (int j = 0; j < boardSize; j++){
        board[i][j] = getRandomLetter();
      }
    }
  }
            
  public void initializeBiggleBoard() {
    for (int i = 1; i < biggleBoard.length - 1; i++) {
      for (int j = 1; j < biggleBoard.length - 1; j++) {
        biggleBoard[i][j] = board[i - 1][j - 1];
      }
    }
  }
}
