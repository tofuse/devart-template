class ColorController {
  
  Annotation annotation;
  
  public ColorController(Annotation a) {
    annotation = a;
    
  
  
  
  }
  
  public color getColor(int currentBase, String currentChrom, color currentColor) {
    
     int r = (currentColor >> 16) & 0xFF;  
     int g = (currentColor >> 8) & 0xFF;   
     int b = currentColor & 0xFF;
    
    if (annotation.isGene(currentBase, currentChrom)  == true) {
      Gene g = annotation.getGene(currentBase,currentChrom);
      
      r = int( float(r) * 0.9);
      g = int( float(g) * 0.5);
      b = int( float(b) * 0.5);
    } else {
       
      r = int( float(r) * 0.9);
      g = int( float(g) * 0.9);
      b = int( float(b) * 0.9);
    }
    return color(r,g,b); 
  }
}
