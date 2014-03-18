class ColorController {
  
  Annotation annotation;
  int currentGeneEnd;
  
  
  public ColorController(Annotation a) {
    annotation = a;
    currentGeneEnd = 0;
  }
  
  public color getMrnaColor(int currentBase, color currentColor){
    //int r = (currentColor >> 16) & 0xFF;  
    //int g = (currentColor >> 8) & 0xFF;   
    //int b = currentColor & 0xFF;
    int c = 0;
    /*
    r = int( float(r) * 0.99);
    g = int( float(g) * 0.99);
    b = int( float(b) * 0.99);
    */
    /*
    if (r == 255 && g == 255 && b == 255) {
      r = 250;
      g = 250;
      b = 250;  
    } else if (r == 250 && g == 250) {
      b = int(float(b) * 0.99);
      if (b <= 2) {
        g = 249;
      }
    } else if (r == 250) {
      g = int(float(g) * 0.99);
      if (g <= 2) {
        r = 249;
      }
    } else {
      r = int(float(r) * 0.99);
    } 
    */
    c = currentColor + 10; 
    
    return c;
  }
  
  public color getColor(int currentBase, String currentChrom, color currentColor) {
    
    int r = (currentColor >> 16) & 0xFF;  
    int g = (currentColor >> 8) & 0xFF;   
    int b = currentColor & 0xFF;
    
    if (currentGeneEnd == 0) {
      if( annotation.isGene(currentBase, currentChrom)  == true) {
        Gene gene = annotation.getGene(currentBase,currentChrom);
        currentGeneEnd = gene.txEnd;
      } else {
        currentGeneEnd = 0;
        r = int( float(r) * 0.99);
        g = int( float(g) * 0.99);
        b = int( float(b) * 0.99);
      }
    } 
    
    if (currentBase < currentGeneEnd) {
      
      if (r> 0.4){
        r = int( float(r) * 0.99);
      }
      g = int( float(g) * 0.59);
      b = int( float(b) * 0.59);
    } else {
      currentGeneEnd = 0;
    } 
    return color(r,g,b);  
   
  }
}
