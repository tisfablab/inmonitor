//ciclo for

for( int i=0; i<10; i++){
 println(i);
}

//array di numeri casuali

int MAX = 10;
float[] tabella = new float[MAX];
for (int i = 0; i < MAX; i++)
tabella[i] = random(1); //random numbers between 0 and 1
println(tabella.length + " elementi:");
println(tabella);