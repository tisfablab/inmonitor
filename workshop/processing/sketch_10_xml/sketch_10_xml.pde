//http://inmonitor.tis.bz.it/xml.php

XML xml;
int ndevice=0;
PFont f = createFont("Georgia", 22);

void setup() {
  size(800, 500);
  //loadData();
}

void draw() {
  background(0);
  loadData();
}

void loadData() {

  xml = loadXML("http://inmonitor.tis.bz.it/xml.php");
  XML[] children = xml.getChildren("device");
  ndevice = children.length;
  println("Numero di device " + ndevice);

  println(xml.getName());

  for (int i = 0; i < ndevice; i++) {
    //stampo il device id 
    int id = children[i].getInt("id");
    println("id =   " + id );

    //seleziono il device
    if (id ==3 ) {
      XML diameterElement0 = children[i].getChild("temperature");
      float d0 = diameterElement0.getFloatContent();
      println("temperature = " + d0 );
      textFont(f);
      fill(204, 102, 0, 190);
      text(d0, width/8, 30);
      noFill();
      //fill(204, 102, 0, 190);
      //noStroke();
      stroke(204, 102, 0, 190);
      ellipse(width/8, height/2, d0, d0);
      stroke(204, 102, 0, 190);
      line(width/8, width, width/8, width/8);

      XML diameterElement1 = children[i].getChild("humidity");
      float d1 = diameterElement1.getFloatContent();
      println("humidity = " + d1 );
      textFont(f);
      fill(204, 222, 1, 190);
      text(d1, width/4, 30);
      noFill();
      //fill(204, 222, 1, 190);
      //noStroke();
      stroke(204, 222, 1, 190);
      ellipse(width/4, height/2, d1, d1);
      line(width/4, width, width/4, width/4);


      XML diameterElement2 = children[i].getChild("pressure");
      float d2 = diameterElement2.getFloatContent();
      println("pressure = " + d2 );
      textFont(f);
      fill(25, 222, 1, 190);
      text(d2, width/2, 30);
      noFill();
      //fill(25, 222, 1, 190);
      //noStroke();
      stroke(25, 222, 1, 190);
      ellipse(width/2, height/2, d2/4, d2/4);
      line(width/2, width, width/2, width/2);

      XML diameterElement3 = children[i].getChild("illuminance");
      float d3 = diameterElement3.getFloatContent();
      println("illuminance = " + d3 );
      textFont(f);
      fill(4, 102, 0, 190);
      text(d3, width/1.2, 30);
      noFill();
      //fill(4, 102, 0, 190);
      //noStroke();
      stroke(4, 102, 0, 190);
      ellipse(width/1.2, height/2, d3, d3);
      line(width/1.2, width, width/1.2, width/2.2);
    }
  }
}