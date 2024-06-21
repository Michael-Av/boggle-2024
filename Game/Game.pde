import java.util.*;
import java.io.*;

Boggle b;
Display d;

void setup(){
  size(1400, 800);
  background(255);
  rectMode(CENTER);
  textAlign(CENTER);
  frameRate(30);
  
  b = new Boggle(5, 2);
  d = new Display(b);
  b.setupGame();
  
  d.drawBoard();
}

void draw(){
  if (frameCount % 30 == 0) {
    b.buildRobotWords(20); // robot is making its words
    b.decrementTime();
    if (b.time == 0) {
      int[] finalScores = b.endGame();
      float robotXToStart = d.displayGame("");
      d.displayRobotWords(b.getRobotWords(), robotXToStart);
      d.displayScores(finalScores);
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
