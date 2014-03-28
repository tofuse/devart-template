class DataPoint {
  
  public int xPos;
  public int yPos;
  public ArrayList<AcidBase> bases;
  public int amountOfBases; // this is redundant to bases.size, but needed because bases is not consolidated for every zoom level.
  
  DataPoint(int x, int y) {
    xPos = x;
    yPos = y;
    bases = new ArrayList<AcidBase>(); 
  }
  
  DataPoint(DataPoint d) {
    xPos = d.xPos;
    yPos = d.yPos;
    bases = new ArrayList<AcidBase>();
    for (AcidBase a : d.bases) {
      bases.add(new AcidBase(a));
      amountOfBases++;
    }
  }
  
  // new xPos/yPos equals xPos/yPos at upperleft corner  
  DataPoint(DataPoint[][] d, int xpos, int ypos, boolean scaleFullMetaData) {
    xPos = xpos;//d[0][0].xPos; //d[0][0] might not exist so it crashes.
    yPos = ypos;//d[0][0].yPos;
    bases = new ArrayList<AcidBase>();
   
    for (int x = 0; x < d.length; x++) {
      for (int y = 0; y < d[0].length; y++) {
        if (d[x][y] != null) {
          for (AcidBase a : d[x][y].getBases()) {
            if(a != null) {
              if (scaleFullMetaData == true) {
                bases.add(new AcidBase(a));
                amountOfBases++;
              } else {   
                amountOfBases++;  
              }  
            }
          }
        }
      }
    }  
  }   

  
  
  
  public void  addAcidBase(char n) {
    bases.add(new AcidBase(n));
    amountOfBases++;
  }  
  
  public ArrayList<AcidBase> getBases(){
    return bases;
  }
  
  public int getAmountOfBases(){
    return amountOfBases;
  }
  
  
  
}
