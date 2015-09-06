String[] words;
int index = 0;

void setup() {
  size(600, 300);
  background(0);
  frameRate(5);

  String[] lines = loadStrings("data.txt");
  String stringone = join(lines, "");
  println(stringone);
  //words= split(stringone, " ");
  words= splitTokens(stringone, ". ,<>*!?/'-_& ");
  printArray(words);
}

void draw() {
  background(0);
  fill(255);
  textSize(64);
  textAlign(CENTER);
  stroke(255);
  textSize(32);
  //text(words[index], width/2, height/2);
  text(words[index].toLowerCase(), width/2, height/2);
  index++;
}