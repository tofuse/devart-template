
import java.lang.Character;
import java.util.Map;

PVector currentPos;
PVector lastPos;

//BufferedReader reader;
String currentLine = "";
int numLines;
int currentBaseNum;
float scaleFactor;
PGraphics context;
String pathToData= "../data/human/";
BufferedReader knownGeneFile;
Annotation annotation;
ColorController colorController;

void setup() {
  noLoop();
  
  annotation = new Annotation(pathToData+"knownGene.txt");
  colorController = new ColorController(annotation);  
  drawChromosome(annotation);
}


void drawChromosome(Annotation a) {
  PGraphics context = createGraphics(10000, 10000);
  context.beginDraw();  
  context.background(255);
  context.endDraw();
  context.loadPixels();
  currentPos = new PVector(context.width / 2, context.height / 2);
  currentBaseNum = 0;
  scaleFactor= 0.1;
  for (int i = 1; i <= 2; i++) {
    drawSequence(pathToData + "chr" + i + ".fa", "chr"+i, context);   
  }
  //drawSequence(pathToData + "chrM.fa", "chrM", context);
  context.updatePixels();
  savePicture(scaleFactor,"humangenome", context);

}

void drawSequence(String fileName, String chromName, PGraphics context) {
  
  BufferedReader reader = createReader(fileName);   
  boolean isFinished = false;
  numLines = 0;
  
  while (isFinished == false) {
    //&& numLines < 100
    try {
      currentLine = reader.readLine();
      
      if (currentLine != null) {
        if (currentLine.charAt(0) == '>') {
         
        } else {
          
          drawLine(currentLine, chromName, context);
          
          if (numLines % 100 == 0) {
            println(numLines);
          }
          numLines++;
        }  
      } else {
        isFinished = true;
        println("FILE FINISHED");
      }
    } 
    catch (IOException e) {
      e.printStackTrace();      
    }   
  }
  
}


void drawLine(String currentLine, String currentChrom, PGraphics context) { 
  
  for (int i = 0; i< currentLine.length(); i++) {
    char acidBase = currentLine.charAt(i);  
    lastPos = new PVector(currentPos.x,currentPos.y);
    if(Character.isUpperCase(acidBase)) {
      acidBase = Character.toLowerCase(acidBase);
    }
    switch (acidBase) {
    case 't':
      currentPos.add(new PVector(0,-1*scaleFactor));
      currentBaseNum++;  
      break;
    case 'c':
      currentPos.add(new PVector(1*scaleFactor,0));
      currentBaseNum++;  
      break;
    case 'a':
      currentPos.add(new PVector(0,1*scaleFactor));
      currentBaseNum++;  
      break;
    case 'g':
      currentPos.add(new PVector(-1*scaleFactor,0));
      currentBaseNum++;  
      break;  
    default:
      currentBaseNum++;  
      break;
    }  
    
    if (currentPos.x >= 0 && currentPos.x <= context.width) {
      if (currentPos.y >= 0 && currentPos.y < context.height) {
        int p = (int)currentPos.y * context.width + (int)currentPos.x;
        //println(currentPos.x+" "+currentPos.y);
        color c = context.pixels[p];
        context.pixels[p] = colorController.getColor(currentBaseNum, currentChrom, c);
      }  
    }
    
    
  }
}

void savePicture(float scaleFactor, String inputFileName, PGraphics context) {
  String dateString = String.valueOf(year())+String.valueOf(month())+String.valueOf(day())+"_"+String.valueOf(hour())+"."+String.valueOf(minute());
  println("saving Frame...");
  context.save(dateString+"_"+scaleFactor+"_"+inputFileName+".png");
  println("..frame saved.");
}


