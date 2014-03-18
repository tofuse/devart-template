class Annotation {
  
  private BufferedReader reader;
  private int numLines;
  //private ArrayList<Gene> genes;
  private HashMap<String,Chromosome> chromosomes = new HashMap<String,Chromosome>();
  
  
  public Annotation(String fileName) {   
    reader = createReader(fileName);     
    boolean isFinished = false;
    numLines = 0;
    //genes = new ArrayList<Gene>();  // Create an empty ArrayList
  
    while (isFinished == false) {
      try {
        currentLine = reader.readLine();
        if (currentLine != null) {
          addGene(new Gene(currentLine));
          //genes.add(new Gene(currentLine));
          numLines++;
        } else {
          isFinished = true;
          println("ANNOTATION FILE READ FINISHED");
        }
      } 
      catch (IOException e) {
        e.printStackTrace();      
      }   
    } 
    println("chromosomes length "+chromosomes.size());
  }
  
  private void addGene(Gene g) {
    String geneChrom = g.chrom;
    
    if(chromosomes.containsKey(geneChrom) ==false) {
      //println(geneChrom);
      chromosomes.put(geneChrom, new Chromosome(geneChrom));
    } else {
      chromosomes.get(geneChrom).addGene(g);
    }
  }
  
  /*
  private Chromosome getChromosome(String chromName) {
    for (int i = 0; i< chromosomes.size(); i++) {
      if (chromosomes.get(i).getName().equals(chromName)) {
        return (chromosomes.get(i))
      }
    }
    Chromosome c = new Chromosome(chromName)
    chromosomes.add(new Chromosome)
  }
  
  */
  public Gene getGene(int currentBase, String currentChrom) {
    Chromosome c = chromosomes.get(currentChrom);
    return c.getGene(currentBase);
  }
  
  
  public Boolean isGene(int currentBaseNum, String ChromName) {
    Boolean isGene = false;
    Chromosome c = chromosomes.get(ChromName);
    
    return c.isGene(currentBaseNum);
  }
 
}
