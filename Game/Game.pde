import java.util.*;
import java.io.*;

Boggle b;
Display d;

void setup(){
  size(1400, 800);
  background(255);
  rectMode(CENTER);
  textAlign(CENTER);
  //frameRate(1000);
  
  b = new Boggle(5);
  d = new Display(b);
  b.setupGame();
  
  d.drawBoard();
}

void draw(){
  if (frameCount % 60 == 0) {
    b.decrementTime();
    if (b.time == 0) {
      int finalScore = b.endGame();
      d.displayGame("");
      text("Score: " + finalScore, width / 2, height / 2);
      noLoop();
    }
  }
  if (b.time != 0)
    d.displayGame(b.currWord.word);
}

void keyReleased(){
  String currWord = b.addLetter(key);
  //d.displayGame(currWord);
}
