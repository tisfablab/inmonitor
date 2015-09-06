///json///

JSONObject json;
///font
PFont f = createFont("Georgia", 22);

//variabili
float temperature_average;
float humidity_average;
float pressure_average;
float illuminance_average;


void setup() {
  size(800, 400);
  frameRate(30);
  background(0);   
  textFont(f);
  fill(204, 102, 0, 190);
  text("illuminance_average", 50, height-80);
}

void draw() {
  loadData();
  graphics();
}

void loadData() {

  json = loadJSONObject("http://inmonitor.tis.bz.it/data.php");

  int device = json.getInt("device");
  temperature_average = json.getFloat("temperature_average");
  humidity_average = json.getFloat("humidity_average");
  pressure_average = json.getFloat("pressure_average");
  illuminance_average = json.getFloat("illuminance_average");

  println("device " +device + 
    ", temperature average " + temperature_average + 
    ", humidity average " + humidity_average +
    ", pressure_average " + pressure_average + 
    ", illuminance_average " + illuminance_average
    );
}
 void graphics(){
     
  //textFont(f);
  //fill(204, 102, 0, 190);
  //text("temperature_average " + temperature_average, 50, height-80);
  noFill();
  //fill(204, 102, 0, 190);
  //noStroke();
  stroke(204, 102, 0, 190);
  ellipse(width/2, height/2, illuminance_average, illuminance_average);
 
 }   
    