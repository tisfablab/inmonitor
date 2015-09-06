String s = "Carlo Erwin Walter";
String[] words;

void setup(){
size(600,300);
background(0);
words = split(s, " ");
}

void draw(){
for (int i=0; i < words.length; i++){
    fill(255, 127);
    stroke(255);
    textSize(32);
    text(words[i], i*120, 150); 

}}