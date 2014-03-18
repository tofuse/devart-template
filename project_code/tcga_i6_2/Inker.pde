class Inker {

  int highestVal = 0;
  int lowestVal = 1000000000;
  color c2 = color(0,0,0);
  color c1 = color(235,235,235);
  
  //xc:#0c0126 xc:#19022a xc:#27032e xc:#43013a xc:#5f0046 xc:#7e003a xc:#9e002f xc:#ce1129 xc:#fe2323 xc:#f6441a xc:#ee6611 xc:#f68617 xc:#ffa61e
  color[] lookupTable;
  
  public Inker(int[] a) {
    println("Inker init..");
    for (int i = 0; i < a.length; i++) {
      if (a[i] > highestVal) {
        highestVal = a[i];
      } 
      if (a[i] < lowestVal) {
        lowestVal = a[i]; 
      }
    }
    println("low: "+  lowestVal);
    println("high: "+  highestVal);
    
    lookupTable = new color[highestVal - lowestVal +1];
    float len = float(lookupTable.length);
    for (int i = 0; i < lookupTable.length; i++){
      lookupTable[i] = lerpColor(c1, c2, float(i)/len);
    }
    println("Done");
  }

  public color ink(int c) {
    if (c == 0) {
          return  color(255);
    }
    return  color(0);//lookupTable[c  - lowestVal];
  }
}
  
