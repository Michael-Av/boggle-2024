public class Boggle{
  char[][] board;
  char[][] biggleBoard;
  int boardSize;
  Word currWord;
  ArrayList<String> words;
  int time;
  Robot[] robots;
  boolean[] uniqueWords;
  
  public Boggle(int size, int numRobots){
    boardSize = size;
    board = new char[size][size];
    biggleBoard = new char[size + 2][size + 2];
    currWord = new Word();
    words = new ArrayList<String>();
    robots = new Robot[numRobots];
    time = 180;
  }
  
  public void setupGame(){
    initializeBoard();
    initializeBiggleBoard();
    for (int i = 0; i < robots.length; i++){
      robots[i] = new Robot(1, "words_scrabble.txt", board, biggleBoard);
    }
  }
  
  public int compareWords(String word1, String word2){
    while (word1.length() > 0 || word2.length() > 0){
      if (word1.length() == 0){
        return -1;
      }
      if (word2.length() == 0){
        return 1;
      }
      
      if (word1.substring(0, 1).compareToIgnoreCase(word2.substring(0, 1)) > 0){
        return 1;
      }
      else if (word1.substring(0, 1).compareToIgnoreCase(word2.substring(0, 1)) < 0){
        return -1;
      }
      
      word1 = word1.substring(1);
      word2 = word2.substring(1);
    }
    return 0;
  }
  
  public boolean dictContains(String word){
    
      String[] words = loadStrings(sketchPath("words.txt"));
      int upperBound = words.length;
      int lowerBound = 0;
      
      while (upperBound - lowerBound > 1){
        int middle = (upperBound + lowerBound) / 2;
        
        int resultValue = compareWords(word, words[middle]);
       // println(words[middle] + ", " + (int)resultValue + ", middle: " + middle + ", lowerbound: " + lowerBound + ", upperbound: " + upperBound);
        if (resultValue == 0){
          return true;
        }
        if (resultValue < 0){
          upperBound = middle;
        }
        if (resultValue > 0){
          lowerBound = middle;
        }
      }
      
      
      return false;
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
    if (word.length() > 3 && ! (words.contains(word)) && checkWord(word) && dictContains(word)) {
      words.add(word);
      currWord = new Word();
      //System.out.println("word [" + word + "] found");
      return true;
    }
    currWord = new Word();
    //System.out.println("word [" + word + "] not found");
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
    for (int i = 0; i < usedCoords.size(); i++) {
      if (coords[0] == usedCoords.get(i)[0] && coords[1] == usedCoords.get(i)[1]) {
        return true;
      }
    }
    return false;
  }
  
  public ArrayList<ArrayList<String>> getRobotWords(){
    ArrayList<ArrayList<String>> robotWords = new ArrayList<ArrayList<String>>();
    for (int i = 0; i < robots.length; i++){
      ArrayList<String> arrayListWords = robots[i].words;
      //printArray(arrayListWords);
      robotWords.add(arrayListWords);
    }
    return robotWords;
  }
  
  public void buildRobotWords(int times){
    for (Robot r: robots){
      for (int i = 0; i < times; i++){
        r.buildWord();
      }
    }
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
  
  public void getUniqueWords(){
    // Initializing boolean arrays
    uniqueWords = new boolean[words.size()];
    for (int i = 0; i < uniqueWords.length; i++){
      uniqueWords[i] = true;
    }
    for (Robot r: robots){
      r.uniqueWords = new boolean[r.words.size()];
      for (int i = 0; i < r.uniqueWords.length; i++){
        r.uniqueWords[i] = true;
      }
    }
    
    for (int i = 0; i < words.size(); i++){
      String currWord = words.get(i);
      for (Robot r: robots){
        for (int j = 0; j < r.words.size(); j++){
          if (currWord.equals(r.words.get(j))){
            uniqueWords[i] = false;
            r.uniqueWords[j] = false;
            break;
          }
        }
      }
    }
    
    for (Robot r: robots){
      for (int i = 0; i < r.words.size(); i++){
        String currWord = r.words.get(i);
        //System.out.println("AAAAAAA " + words.size());
        for (int j = 0; j < words.size(); j++){
          if (currWord.equals(words.get(j))){
            r.uniqueWords[i] = false;
            uniqueWords[j] = false;
            break;
          }
        }
        for (Robot r2: robots){
          if (r == r2){
            continue;
          }
          
          for (int j = 0; j < r2.words.size(); j++){
            if (currWord.equals(r2.words.get(j))){
              r.uniqueWords[i] = false;
              r2.uniqueWords[j] = false;
              break;
            }
          }
        }
      }
    }
  }
  
  public int[] endGame(){
    getUniqueWords();
    
    int[] allScores = new int[robots.length + 1]; // for player plus robots
    int sumPlayer = 0;
    for (int i = 0; i < words.size(); i++){
      if (uniqueWords[i] == true){
        sumPlayer += words.get(i).length() - 3;
      }
    }
    allScores[0] = sumPlayer;
    
    for (int i = 0; i < robots.length; i++){
      ArrayList<String> rWords = robots[i].words;
      int sumThisRobot = 0;
      for (int j = 0; j < rWords.size(); j++){
        if (robots[i].uniqueWords[j] == true){
          sumThisRobot += rWords.get(j).length() - 3;
        }
      }
      allScores[i + 1] = sumThisRobot;
    }
    return allScores;
  }
  
  public void decrementTime() {
    time--;
  }
}
