
// initial test to visualize a dna sequence
// t means up 
// c means left
// a means down
// g means right

import java.lang.Character;

PVector currentPos;
PVector lastPos;

//BufferedReader reader;
String currentLine = "";
int numLines;
float scaleFactor;
PGraphics context;
String pathToData= "../data/human/";


//draws multiple pictures
void setup() {
  noLoop();
  for (int j = 0; j < 1; j++) {
    PGraphics context = createGraphics(10000,10000);
    context.beginDraw();  
    context.background(255);
    context.endDraw(); 
    context.loadPixels();
    currentPos = new PVector(context.width / 2, (context.height / 2 + context.height * j));
    scaleFactor= 0.01;
    for (int i = 1; i <= 1; i++) {
      drawSequence(pathToData + "chr" + i + ".fa", "chr"+i, context);   
    }
    //drawSequence(pathToData + "chrM.fa", "chrM", context);
    //context.endDraw();
    savePicture(scaleFactor,"humangenome"+j, context);
  }
}


void drawSequence(String fileName, String outputName, PGraphics context) {
  
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
          
          drawLine(currentLine, context);
          
          if (numLines % 100000 == 0) {
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
      case 'a':
        currentPos.add(new PVector(0,1*scaleFactor));
        break;
      case 'g':
        currentPos.add(new PVector(-1*scaleFactor,0));
        break;  
      default:
        break;
    }  
    //context.line((int)currentPos.x,(int)currentPos.y,(int)lastPos.x,(int)lastPos.y);
    
    //context.set((int)currentPos.x,(int)currentPos.y,color(0,0,0,50)); 
    if (currentPos.x >= 0 && currentPos.x <= context.width) {
      if (currentPos.y >= 0 && currentPos.y < context.height) {
        int p = (int)currentPos.y * context.width + (int)currentPos.x;
        //println(currentPos.x+" "+currentPos.y);
        color c = context.pixels[p];
        int r = (c >> 16) & 0xFF;  
        int g = (c >> 8) & 0xFF;   
        int b = c & 0xFF;  
        r = int( float(r) * 0.99);
        g = int( float(g) * 0.99);
        b = int( float(b) * 0.99);
        
        
        color argb =  color(r,g,b); 
        context.pixels[p] = argb;
      }  
    }  
  }
}

void savePicture(float scaleFactor, String inputFileName, PGraphics context) {
  context.updatePixels();
  String dateString = String.valueOf(year())+String.valueOf(month())+String.valueOf(day())+"_"+String.valueOf(hour())+"."+String.valueOf(minute());
  println("saving Frame...");
  context.save(dateString+"_"+scaleFactor+"_"+inputFileName+".png");
  println("..frame saved.");
}


