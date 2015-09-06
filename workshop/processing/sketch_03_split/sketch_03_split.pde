size(600,300);
background(0);

String s = "100,40,50,060,23,54,75";
String [] nums = split(s, ",");

//casting 
int[] vals = int(nums);

for (int i=0; i < nums.length; i++){
  
 ellipse(i*70, 150 ,vals[i],vals[i]); 
  
}