class ColorController {
  
  Annotation annotation;
  int currentGeneEnd;
  
  
  public ColorController(Annotation a) {
    annotation = a;
    currentGeneEnd = 0;
  }
  
  public color getMrnaColor(int currentBase, color currentColor){
    int r = (currentColor >> 16) & 0xFF;  
    int g = (currentColor >> 8) & 0xFF;   
    int b = currentColor & 0xFF;
    r = int( float(r) * 0.99);
    g = int( float(g) * 0.99);
    b = int( float(b) * 0.99);
    return color(r,g,b);
  }
}
