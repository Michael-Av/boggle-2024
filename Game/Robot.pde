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
    int row = (int)(Math.random() * 5);
    int col = (int)(Math.random() * 5);
    return new int[]{row, col};
  }
  
  public void buildWord(){
    currWord = "";
    int r = (int) (Math.random() * 5) + 1;
    int c = (int) (Math.random() * 5) + 1;
    int[] currLetter = {r, c};
    //System.out.println("starting with letter [" + biggleBoard[r][c] + "] at coords (" + r + ", " + c + ")");
    ArrayList<int[]> usedCoords = new ArrayList<>();
    while (! t.isWord(currWord) || currWord.length() < 4) {
      usedCoords.add(currLetter);
      ArrayList<int[]> potentialNextCoords = findPotentialNextCoords(currLetter, usedCoords);
      //System.out.println("currWord: " + currWord);
      ArrayList<Character> potentialNextCharacters = t.getNextLetterOptions(currWord);
      boolean nextLetterFound = false;
      /*for (int[] coords : potentialNextCoords) {
        System.out.println("potential next coords: (" + coords[0] + ", " + coords[1] + ")");
      }
      for (char ch : potentialNextCharacters) {
        System.out.print(ch + ", ");
      }
      System.out.println();*/
      while (potentialNextCoords.size() > 0) {
        int nextLetterIndex = (int) (Math.random() * potentialNextCoords.size());
        int[] nextLetterCoords = potentialNextCoords.get(nextLetterIndex);
        char nextLetter = biggleBoard[nextLetterCoords[0]][nextLetterCoords[1]];
        //System.out.println("chosen potential next Letter [" + nextLetter + "] at coords (" + nextLetterCoords[0] + ", " + nextLetterCoords[1] + ")");
        //System.out.println("charInList(nextLetter, potentialNextCharacters): " + charInList(nextLetter, potentialNextCharacters));
        if (charInList(nextLetter, potentialNextCharacters)) {
          currLetter = nextLetterCoords;
          nextLetterFound = true;
          currWord += biggleBoard[currLetter[0]][currLetter[1]];
          //System.out.println("next letter [" + biggleBoard[currLetter[0]][currLetter[1]] + "] found at (" + currLetter[0] + ", " + currLetter[1] + ")");
          //System.out.println("currWord: " + currWord);
          break;
        } else {
          potentialNextCoords.remove(nextLetterIndex);
          //System.out.println("(" + nextLetterCoords[0] + ", " + nextLetterCoords[1] + ") removed from potentialNextCoords");
        }
      }
      if (! nextLetterFound) {
        return;
      }
    }
    //System.out.println("returning currWord");
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
  
  
