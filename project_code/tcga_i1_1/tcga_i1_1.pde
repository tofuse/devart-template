
// initial test to visualize a dna sequence
// t means up 
// c means left
// g means down
// a means right

import java.lang.Character;

PVector currentPos;
PVector lastPos;

BufferedReader reader;
String currentLine = "";
int numLines =0;

void setup() {
  size(10000,20000);
  background(255);
  noLoop();
  reader = createReader("../data/human/chr1.fa");
  boolean finished = false;
  currentPos = new PVector(width / 2, height / 2);

  while (finished == false && numLines < 10000) {
    try {
      currentLine = reader.readLine();
      if (currentLine != null) {
        if (currentLine.charAt(0) == '>') {
         
        } else {
          drawLine(currentLine);
          numLines++;
        }  
      } else {
        finished = true;
        println("FILE FINISHED");
      }
    } 
    catch (IOException e) {
      e.printStackTrace();
      
    }   
  }
  savePicture();
}

void drawLine(String currentLine) { 
  println("dddd");
      stroke(0);
      for (int i = 0; i< currentLine.length(); i++) {
        
        char acidBase = currentLine.charAt(i);  
        lastPos = new PVector(currentPos.x,currentPos.y);

        if(Character.isUpperCase(acidBase)) {
          acidBase = Character.toLowerCase(acidBase);
        }
        //println(acidBase);
        switch (acidBase) {
        case 't':
          currentPos.add(new PVector(0,-1));
          break;
        case 'c':
          currentPos.add(new PVector(1,0));
          break;
        case 'g':
          currentPos.add(new PVector(0,1));
          break;
        case 'a':
          currentPos.add(new PVector(-1,0));
          break;  
        default:
          break;
        }    
         
        line((int)currentPos.x,(int)currentPos.y,(int)lastPos.x,(int)lastPos.y);
      }
}


void savePicture() {
  String dateString = String.valueOf(year())+String.valueOf(month())+String.valueOf(day())+"_"+String.valueOf(hour())+"."+String.valueOf(minute());
  println("saving Frame...");
  save(dateString+"chr1.png");
  println("..frame saved.");
}


