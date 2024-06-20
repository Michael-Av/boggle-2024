public class TrieNode {
  TrieNode[] children;
  String currentString;
  boolean isWord;  
  
  public TrieNode(String constructedString) {
    children = new TrieNode[26];
    currentString = constructedString;
    isWord = false;
  }
  
  public TrieNode(String constructedString, boolean isFullWord) {
    children = new TrieNode[26];
    currentString = constructedString;
    isWord = isFullWord;
  }
  
  public TrieNode getChild(int position) {
    return children[position];
  }
  
  public TrieNode getChild(char nextLetter) {
    return children[letterToArrayPosition(nextLetter)];
  }
  
  private void setChild(int position, TrieNode newNode) {
    children[position] = newNode;
  }
  
  public boolean getWordStatus() {
    return isWord;
  }
  
  public void setWordStatus(boolean status) {
    isWord = status;
  }
  
  
  public void constructNewChild(char newLetter) {
    int position = letterToArrayPosition(newLetter);
    if (getChild(position) != null) {
      return;
    }
    TrieNode enter = new TrieNode(currentString + newLetter);
    setChild(position, enter);
  }
  
  public TrieNode goToNextLetter(char letter) {
    TrieNode next = getChild(letter);
    if (next != null) return next;
    constructNewChild(letter);
    return getChild(letter);
  }
  
  
  public int letterToArrayPosition(char letter) {
    return letter - 'a';
  }
  
  public char arrayPositionToLetter(int position) {
    return (char) (position + 'a');
  }
  
  
  public ArrayList<Character> nextEntries() {
    ArrayList<Character> entries = new ArrayList<Character>();
    for (int i = 0; i < children.length; ++i) {
      if (getChild(i) != null) {
        entries.add(arrayPositionToLetter(i));
      }
    }
    return entries;
  }
  
  
}
