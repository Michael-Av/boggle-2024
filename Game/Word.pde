public class Word{
  private String word;
  
  public Word(){
    word = "";
  }
  
  // 0  means letter added successfully, 1 means letter removed,
  // 2 means invalid letter, 3 means word completed
  public int addLetter(char letter){
    if (letter == '\n')
      return 3;
    if (letter == 8){
      if (word.length() > 0){
        word = word.substring(0, word.length() - 1);
      }
      return 1;
    }
    if (! Character.isAlphabetic(letter)){
      return 2;
    }
    else {
      word = word + letter;
      return 0;
    }
  }
  
  public String getWord(){
    return word;
  }
}
