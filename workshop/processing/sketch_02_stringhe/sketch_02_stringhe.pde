size(1200, 450);
background(0);

println(PFont.list());

PFont f = createFont("Georgia", 64);

//ricorda String e un oggetto
String s = "ricorda String e' un oggetto";
print (s);

textFont(f);
text(s.charAt(0), 20 ,50);

int x = 20;

for(int i=0; i < s.length(); i++){
text(s.charAt(i), x ,150);
x= x + 32;
}

int y = 20;
for(int i=0; i < s.length(); i++){
  char c = s.charAt(i);
  fill(random(255));
  textSize(random(12,128));
  text(c, y ,250);
  y= y + 32;
}