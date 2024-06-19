Boggle b;
Display d;

void setup(){
  size(1400, 800);
  background(255);
  
  b = new Boggle(5);
  d = new Display(b);
}

void draw(){
  d.drawBoard();
}
