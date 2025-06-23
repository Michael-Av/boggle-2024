import java.util.*;
import java.io.*;

Boggle b;
Display d;


///////// MODIFYABLE PARAMETERS /////////
// Difficulties is just how many times per second the robots try to make a word per second
float[] robotDifficulties = {1, 1};
int numRobots = robotDifficulties.length;
int boardSize = 5;
int time = 180; // in seconds

// Only modify these variables if you know what you're doing
String playerDictionary = "words.txt";
String robotDictionary = "words_scrabble.txt";
int rate=30;
// //////////////////////////////////////

void setup(){
  size(100, 100);
  fullScreen();
  background(255);
  frameRate(rate);
  textSize(15);
  
  
  b = new Boggle(boardSize, numRobots, time, playerDictionary, robotDictionary);
  d = new Display(b);
}

void draw(){
  if (frameCount % rate == 0) {
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
