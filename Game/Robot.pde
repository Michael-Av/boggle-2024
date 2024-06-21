public class Robot{
  private int difficulty;
  String currWord;
  DictionaryTrie t;
  String[] words;
  char[][] board
  
  public Robot(int diff, String dict, char[][] board){
    difficulty = diff;
    t = new DictionaryTrie();
    this.board = board;
    currWord = t.root;
    initializeDictTrie(dict);
  }
  
  public void initializeDictTrie(String dictionary){
    String[] words = loadStrings(dictionary);
    
    for (String w: words){
      t.addWord(w);
    }
  }
  
  public int[] findFirstLetterCoords(){
    int row = (int)(Math.random() * 5);
    int col = (int)(Math.random() * 5);
    return new int[]{row, col};
  }
  
  public boolean buildWord(){
    return true;
  }
    
  
  public ArrayList<int[]> findPotentialNextCoords(int[] currLocation){
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
  
  
