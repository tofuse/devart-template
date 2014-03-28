class AcidBase {
  // base has to be lowercase
  public char base;
  
  AcidBase(char b) {
    base = b;
  }
  
  AcidBase(AcidBase a) {
    base = a.base;
  }    
}  
