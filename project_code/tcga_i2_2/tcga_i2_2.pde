
//renders all chromosomes into separate files
import java.lang.Character;

PVector currentPos;
PVector lastPos;

//BufferedReader reader;
String currentLine = "";
int numLines;
float scaleFactor;
PGraphics context;
String pathToData= "../data/human/";

void setup() {
  noLoop();
  for (int i = 1; i <= 22; i++) {
    println("chr" + i + ".fa");
    drawSequence(pathToData + "chr" + i + ".fa", "chr"+i);   
  }
  drawSequence(pathToData + "chrM.fa", "chrM");
}


void drawSequence(String fileName, String outputName) {
  
  BufferedReader reader = createReader(fileName);   
  boolean isFinished = false;
  numLines = 0;
  PGraphics context = createGraphics(10000,10000);
  context.beginDraw();  
  context.background(255);
  context.stroke(0);
  
  currentPos = new PVector(context.width / 2, context.height / 2);
  scaleFactor= 0.01;
  
  while (isFinished == false ) {
    //&& numLines < 100
    try {
      currentLine = reader.readLine();
      
      if (currentLine != null) {
        if (currentLine.charAt(0) == '>') {
         
        } else {
          
          drawLine(currentLine, context);
          
          if (numLines % 10000 == 0) {
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
  context.endDraw();
  savePicture(scaleFactor,outputName, context);
}


void drawLine(String currentLine, PGraphics context) { 
  
  for (int i = 0; i< currentLine.length(); i++) {
    char acidBase = currentLine.charAt(i);  
    lastPos = new PVector(currentPos.x,currentPos.y);
    if(Character.isUpperCase(acidBase)) {
      acidBase = Character.toLowerCase(acidBase);
    }
    
    switch (acidBase) {
    case 't':
      currentPos.add(new PVector(0,-1*scaleFactor));
      break;
    case 'c':
      currentPos.add(new PVector(1*scaleFactor,0));
      break;
    case 'g':
      currentPos.add(new PVector(0,1*scaleFactor));
      break;
    case 'a':
      currentPos.add(new PVector(-1*scaleFactor,0));
      break;  
    default:
      break;
    }    
    context.line((int)currentPos.x,(int)currentPos.y,(int)lastPos.x,(int)lastPos.y);
  }
}

void savePicture(float scaleFactor, String inputFileName, PGraphics context) {
  String dateString = String.valueOf(year())+String.valueOf(month())+String.valueOf(day())+"_"+String.valueOf(hour())+"."+String.valueOf(minute());
  println("saving Frame...");
  context.save(dateString+"_"+scaleFactor+"_"+inputFileName+".png");
  println("..frame saved.");
}


