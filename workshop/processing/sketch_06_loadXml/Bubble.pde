class Bubble {
  float x,y;
  float diameter;

  Bubble(float x_, float y_, float diameter_) {
    x = x_;
    y = y_;
    diameter = diameter_;
    
  }

  void display() {
    stroke(0);
    strokeWeight(2);
    noFill();
    ellipse(x,y,diameter,diameter);
  }
}