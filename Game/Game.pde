Boggle b;
Display d;

void setup(){
  size(1400, 800);
  background(255);
  rectMode(CENTER);
  textAlign(CENTER);
  
  b = new Boggle(5);
  d = new Display(b);
  b.setupGame();
}

void draw(){
  d.drawBoard();
}
