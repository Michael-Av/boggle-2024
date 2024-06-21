public class DictionaryTrie {
  public TrieNode root;
  
  
  public DictionaryTrie() {
    root = new TrieNode("", false);
  }
  
  public void addWord(String word) {
    TrieNode curr = root;
    for (int i = 0; i < word.length(); ++i) {
      curr = curr.goToNextLetter(word.charAt(i));
    }
    curr.setWordStatus(true);
  }
  
  private TrieNode getLastLetterNode(String word) {
    TrieNode curr = root;
    for (int i = 0; i < word.length(); ++i) {
      if (curr == null) return null;
      curr = curr.getChild(word.charAt(i));
    }
    return curr;
  }
  
  public boolean isWord(String word) {
    TrieNode last = getLastLetterNode(word);
    if (last == null) return false;
    return last.getWordStatus();
  }
  
  
  public ArrayList<Character> getNextLetterOptions(String prefix) {
    TrieNode last = getLastLetterNode(prefix);
    if (last == null) return new ArrayList<Character>();
    return last.nextEntries();
  }
  
  
}
