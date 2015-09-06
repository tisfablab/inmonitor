//Una classe è denita da un insieme di dati e funzioni.
//Un oggetto è una istanza di una classe. 
//una classe è una descrizione astratta di un insieme di oggetti.

//Dichiarazione: (Dot myDot;)
//Allocazione: (myDot = new Dot(tempcolor,0))
//Utilizzazione: (myDot.disegna(10);)


Dot myDot;

void setup() {
  size(800, 300);
  colorMode(RGB, 255, 255, 255, 100);
  color tempcolor = color(255, 0, 0);
  myDot = new Dot(tempcolor, width/2);
}
void draw() {
  background(0);
  //myDot.disegna(int (random(height)));
  myDot.disegna(50);
  myDot.disegna(200);
  myDot.disegna(150);
}


class Dot
{
  color colore;
  int posizione;

  //****CONSTRUCTOR*****//
  Dot(color c_, int xp) {
    colore = c_;
    posizione = xp;
  }

  void disegna (int ypos) {
    rectMode(CENTER);
    fill(colore);
    rect(posizione, ypos, 20, 10);
  }
}