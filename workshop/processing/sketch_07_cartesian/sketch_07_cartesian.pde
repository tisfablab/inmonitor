
float [] r = { 
  90, 30, 220, 185
};
float angle= 0;
int counter = 0;

void setup() {
  size(650, 650);
  background(250);
  frameRate(2);
}

void draw() {

  if ( counter < 20000) {
    for (int n =0; n < r.length; n++) {
      float x = r[n] * cos(angle);
      float y = r[n] * sin(angle);

      noFill();
      //ellipse(x + width/2, y + height/2, 16, 16);
      line(width/2, height/2, x + width/2, y + height/2);

      angle +=0.2;
      counter ++;
    }
  }
}

