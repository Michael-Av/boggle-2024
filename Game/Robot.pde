public class Robot{
  private int difficulty;
  String currWord;
  DictionaryTrie t;
  ArrayList<String> words;
  char[][] board;
  char[][] biggleBoard;
  boolean[] uniqueWords;
  
  public Robot(int diff, String dict, char[][] board, char[][] biggleBoard){
    difficulty = diff;
    t = new DictionaryTrie();
    words = new ArrayList<String>();
    this.board = board;
    this.biggleBoard = biggleBoard;
    currWord = "";
    initializeDictTrie(dict);
  }
  
  public void initializeDictTrie(String dictionary){
    String[] words = loadStrings(dictionary);
    
    for (String w: words){
      t.addWord(w.toUpperCase());
    }
  }
  
  public int[] findFirstLetterCoords(){
    int row = (int)(Math.random() * board.length) + 1;
    int col = (int)(Math.random() * board.length) + 1;
    return new int[]{row, col};
  }
  
  public void buildWord(){
    currWord = "";
    int[] currLetter = findFirstLetterCoords();
    currWord += biggleBoard[currLetter[0]][currLetter[1]];
    ArrayList<int[]> usedCoords = new ArrayList<>();
    while (! t.isWord(currWord) || currWord.length() < 4) {
      System.out.println("currWord: " + currWord);
      usedCoords.add(currLetter);
      ArrayList<int[]> potentialNextCoords = findPotentialNextCoords(currLetter, usedCoords);
      ArrayList<Character> potentialNextCharacters = t.getNextLetterOptions(currWord);
      boolean nextLetterFound = false;
      while (potentialNextCoords.size() > 0) {
        int nextLetterIndex = (int) (Math.random() * potentialNextCoords.size());
        int[] nextLetterCoords = potentialNextCoords.get(nextLetterIndex);
        char nextLetter = biggleBoard[nextLetterCoords[0]][nextLetterCoords[1]];
        if (charInList(nextLetter, potentialNextCharacters)) {
          currLetter = nextLetterCoords;
          nextLetterFound = true;
          currWord += biggleBoard[currLetter[0]][currLetter[1]];
          break;
        } else {
          potentialNextCoords.remove(nextLetterIndex);
        }
      }
      if (! nextLetterFound) {
        return;
      }
    }
    if (! words.contains(currWord)) {
      words.add(currWord);
    }
  }
  
  boolean charInList(char c, ArrayList<Character> list) {
    for (int i = 0; i < list.size(); i++) {
      if (c == list.get(i)) {
        return true;
      }
    }
    return false;
  }
    
  public ArrayList<int[]> findPotentialNextCoords(int[] currLocation, ArrayList<int[]> usedCoords){
    ArrayList<int[]> potentialNextCoords = new ArrayList<>();
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        int row = currLocation[0] + i;
        int col = currLocation[1] + j;
        if (! coordAlreadyUsed(new int[] {row, col}, usedCoords)) {
          potentialNextCoords.add(new int[]{row, col});
        }
      }
    }
    return potentialNextCoords;
  }
  
  public boolean coordAlreadyUsed(int[] coords, ArrayList<int[]> usedCoords) {
    for (int i = 0; i < usedCoords.size(); i++) {
      if (coords[0] == usedCoords.get(i)[0] && coords[1] == usedCoords.get(i)[1]) {
        return true;
      }
    }
    return false;
  }
}
  
  
