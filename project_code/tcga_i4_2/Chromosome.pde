class Chromosome {
  // used by annotation
  ArrayList<Gene> genes;
  String name;
  
  public Chromosome(String n) {
    name = n;
    genes = new ArrayList<Gene>();
  }

  public void addGene(Gene g) {
    genes.add(g);
  }
  
  
  public Boolean isGene(int currentBaseNum) {
    Boolean isGene = false;
    for (int i = 0; i < genes.size(); i++) {
      if (genes.get(i).isGene(currentBaseNum) == true) {
        isGene = true;
        break;
      }
    } 
    return isGene;
  }
  
  
}
