import java.util.*;
import java.io.*;

Boggle b;
Display d;

// Changeable parameters
// ------------------------------------
//int numRobots = 2;
float[] robotDifficulties = {1, 1, 1};
int numRobots = robotDifficulties.length;
int boardSize = 5;
int time = 180; // in seconds
String playerDictionary = "words.txt";
String robotDictionary = "words_scrabble.txt";
// --------------------------------------

void setup(){
  size(1400, 800);
  background(255);
  frameRate(30);
  textSize(15);
  
  b = new Boggle(boardSize, numRobots, time, playerDictionary, robotDictionary);
  d = new Display(b);
}

void draw(){
  if (frameCount % 30 == 0) {
    b.buildRobotWords(robotDifficulties); // robot is making its words
    b.decrementTime();
    if (b.time == 0) {
      int[] finalScores = b.endGame();
      d.displayGame("", true);
      d.displayScores(finalScores);
      noLoop();
    }
  }
  if (b.time != 0)
    d.displayGame(b.currWord.word, false);
}

void keyReleased(){
  String currWord = b.addLetter(key);
  //d.displayGame(currWord);
}
