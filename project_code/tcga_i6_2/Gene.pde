class Gene {

// name  NM_001011874  varchar(255)  values  Name of gene
String name; 
// chrom  chr1  varchar(255)  values  Reference sequence chromosome or scaffold
String chrom;
// strand  -  char(1)  values  + or - for strand
Boolean strand; // yes means + 
// txStart  3204562  int(10) unsigned  range  Transcription start position
int txStart;
// txEnd  3661579  int(10) unsigned  range  Transcription end position
int txEnd;
// cdsStart  3206102  int(10) unsigned  range  Coding region start
int cdsStart;
// cdsEnd  3661429  int(10) unsigned  range  Coding region end
int cdsEnd;
// exonCount  3  int(10) unsigned  range  Number of exons
int exonCount;
// exonStarts  3204562,3411782,3660632,  longblob     Exon start positions
int[] exonStarts;
// exonEnds  3207049,3411982,3661579,  longblob     Exon end positions
int[] exonEnds;
// proteinID  XKR4_MOUSE  varchar(40)  values  UniProt display ID for Known Genes, UniProt accession or RefSeq protein ID for UCSC Genes
String proteinID;
// alignID  R1  varchar(8)  values  Unique identifier for each (known gene, alignment position) pair
  
  public Gene(String text) {
    String[] list = splitTokens(text);
    name = list[0];
    chrom = list[1];
    strand = (list[2].equals("+")) ? true : false;
    txStart = int(list[3]);
    txEnd = int(list[4]);
    cdsStart = int(list[5]);
    cdsEnd = int(list[6]);
    exonCount = int(list[7]);
    String[] eS = split(list[8], ',');
    exonStarts = new int[exonCount];
    for (int i = 0; i < exonCount; i++) {
      exonStarts[i] = int(eS[i]);
    }
    String[] eE = split(list[9], ',');
    exonEnds = new int[exonCount];
    for (int i = 0; i < exonCount; i++) {
      exonEnds[i] = int(eE[i]);
    }
    //println(toString());
  }   
  
  public Boolean isGene(int currentBaseNum) {
    if (currentBaseNum >= txStart && currentBaseNum <= txEnd) {
      return true;
    } 
    return false;
  }
  
  public String toString() {
    return (name+", " + chrom + 
    " strand: "+strand+
    " txS:"+txStart+
    " txE:"+txEnd+
    "cdsStart: "+cdsStart+
    "cdsEnd: "+cdsEnd+
    "exonCount: "+exonCount+
    " "+exonStarts.toString()
    );
    
  }

}
