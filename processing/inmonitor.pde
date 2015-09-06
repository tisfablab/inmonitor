////------------INMONITOR--------------------//// //<>//
//http://inmonitor.tis.bz.it/xml.php

// dichiarazione oggetti
XML xml;
PFont f = createFont("Georgia", 16);
//dichiarazione di array 
float [] id;
float [] d0;
float [] d1;
float [] d2;
float [] d3;
//dichiarazione di variabili
int ndevice;

int marg;
int spaz;
float  [] dis;

void setup() {
  size(1200, 400);
  frameRate(30);
  background(0);
  loadData();
  println("Numero di device " + ndevice);
  marg = 100;

  dis = new float[ndevice];
  spaz = (width-marg*2) / (ndevice-1);  

  for (int i=0; i<ndevice; i++) {
    dis[i] = marg;
    marg = marg +spaz;
  }
}

void draw() {

  //loadData();
  
 //carico i dati ogni 60 frame 
   if (frameCount % 60 == 0) {
   thread("loadData");
   }
  
  background(0);

  //uso i dati

  for (int i = 0; i < ndevice; i++) {
    stroke(200, 35, 0, 190);
    noFill();
    line(dis[i], 0, dis[i], height-70);
    noFill();
    stroke(204, 102, 0, 190);
    ellipse(dis[i], 50, d0[i], d0[i]);
    stroke(24, 102, 0, 190);
    ellipse(dis[i], 100, d1[i], d1[i]);
    stroke(204, 12, 0, 190);
    ellipse(dis[i], 150, d2[i], d2[i]); 
    stroke(204, 102, 120, 190);
    ellipse(dis[i], 200, d3[i], d3[i]);
    
   textFont(f);
   fill(204, 102, 0);
   //text("inMonitor " + id[i], dis[i]-50, height-30);
   text ("inMonitor", width-100 ,height-30);
  }
}

void loadData() {
  xml = loadXML("http://inmonitor.tis.bz.it/xml.php");
  XML[] children = xml.getChildren("device");
  ndevice = children.length;
  println("Numero di device " + ndevice);
  println(xml.getName());
  
  id = new float[ndevice];
  d0 = new float[ndevice];
  d1 = new float[ndevice];
  d2 = new float[ndevice];
  d3 = new float[ndevice];

  for (int i = 0; i < ndevice; i++) {
    //stampo il device id 
    id[i] = children[i].getInt("id");
    println("id =   " + id[i] );

    //seleziono il device altrimenti leggo tutti i dati dei device

    //if (id ==99 ) {
    XML diameterElement0 = children[i].getChild("temperature");
    d0[i] = diameterElement0.getFloatContent();
    println("temperature = " + d0[i] );

    XML diameterElement1 = children[i].getChild("humidity");
    d1[i] = diameterElement1.getFloatContent();
    println("humidity = " + d1[i] );

    XML diameterElement2 = children[i].getChild("pressure");
    d2[i] = (diameterElement2.getFloatContent())/10;
    println("pressure = " + d2[i] );

    XML diameterElement3 = children[i].getChild("illuminance");
    d3[i] = diameterElement3.getFloatContent();
    println("illuminance = " + d3[i]   );
    // }
  }
}