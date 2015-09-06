
Bubble[] bubbles;
XML xml;

void setup() {
  size(480, 300);
  loadData();
}

void draw() {
  background(255);

  for (Bubble b : bubbles) {
    b.display();
  }
}

void loadData() {

  xml = loadXML("data.xml");
  XML[] children = xml.getChildren("device");
  bubbles = new Bubble[children.length]; 
  println(xml.getName());

  for (int i = 0; i < bubbles.length; i++) {

    XML positionElementX = children[i].getChild("temperature");
    float x = positionElementX.getFloatContent();
    println("x =" + x );

    XML positionElementY = children[i].getChild("humidity");
    float y = positionElementY.getFloatContent();
    println("y =" + y );


    XML diameterElement = children[i].getChild("pressure");
    float diameter = diameterElement.getFloatContent();
    println("diameter =" + diameter );

    bubbles[i] = new Bubble(x, y, diameter);
  }
}