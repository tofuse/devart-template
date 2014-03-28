//based on tcga_i4_3

import java.lang.Character;
import java.util.Map;

void setup() {
  noLoop();
  String pathToFA = "../data/human/";
  String pathToAnnotation = "../data/human/";
  String DNAfileName = "chrY.fa";
  String AnnotationFileName = "knownGene.txt";
  
  Annotation annotation = new Annotation(pathToAnnotation+AnnotationFileName);
  ColorController colorController = new ColorController(annotation);
  String savePath0 = "./"+String.valueOf(year())+String.valueOf(month())+String.valueOf(day())+"_"+String.valueOf(hour())+"."+String.valueOf(minute());
  
  int startZoom = 5;
  int globalTileAmountX = int(pow(2,startZoom));
  int globalTileAmountY = globalTileAmountX; // amount of starting tiles: (for these a new datamap is computed, size defines min zoomlevel.)
  int minLocalZoomLevel = 0;// small 
  int maxLocalZoomLevel = minLocalZoomLevel + 7; // 1:1 1024px wide
  int maxOverZoomLevel = maxLocalZoomLevel + 4; // 2:1, 4:1 etc.
  
  
  for (int gx = 0; gx < globalTileAmountX; gx++) {
    for (int gy = 0; gy < globalTileAmountY; gy++) {
      
      int gSize = 256 * int(pow(2,maxLocalZoomLevel - minLocalZoomLevel));
      DataPoint[][] dataMap = new DataPoint[gSize][gSize];
      int spX = gSize * globalTileAmountX / 2 - gx * gSize;
      int spY = gSize * globalTileAmountY / 2 - gy * gSize;
      PVector startPos = new PVector(spX, spY);
      //new PVector(256 * tileAmount / 2 - x * 256, 256 * tileAmount / 2 - y * 256);
      dataMap = computeChromosome(
        colorController, 
        dataMap,
        pathToFA,  
        DNAfileName,
        startPos, 
        1
      );
      println("Global " + gx + "," + gy + ": Compute Chromosome finished.");
        
      if (isEmpty(dataMap) == false) {
        
        for (int z = minLocalZoomLevel; z <= maxOverZoomLevel; z++) {
          println("zoomlevel: " + z);
          
          String savePath1 = savePath0+"/" + (z + startZoom) + "/";
          
          int tileAmountX = int(pow(2,z));
          float scaleFactor= 1 / pow(2, maxLocalZoomLevel - z);
          for (int x = 0; x < tileAmountX; x++) {
            println("gx: "+gx);
            println("x: "+x);
            println("tileAmount: "+tileAmountX);
            String savePath2 = savePath1 + (tileAmountX * gx + x)+ "/";
            
            for (int y = 0; y < tileAmountX; y++) {
              int w = dataMap.length / tileAmountX;
              int h = dataMap[0].length / tileAmountX;
              DataPoint[][] data = getData(dataMap, x * w, y * h, w, h);        
              if (isEmpty(data) == false ) {
                boolean scaleFullMetaData = false;
                if (z >= (maxLocalZoomLevel - 2)) {
                  scaleFullMetaData = true;
                }
                if (z <= maxLocalZoomLevel) {
                  data = scaleData(data, 256, scaleFullMetaData);
                } else {
                  //data = scaleData(data, 256 / , scaleFullMetaData);
                }
                PGraphics context = createGraphics(256, 256);        
                context = drawTile(data, context, minLocalZoomLevel, maxLocalZoomLevel, maxOverZoomLevel, z, scaleFactor);
                context.save(savePath2 + (tileAmountX * gy + y) + ".png");
                println(savePath2 + (tileAmountX * gy + y) + ".png");
              }
            }    
          }   
        }
      }
    }
  }  
  println("FINISHED");
}

PGraphics drawTile(DataPoint[][] data, PGraphics context, int minZoomLevel, int maxZoomLevel, int maxOverZoomLevel, int zoomLevel, float scaleFactor) {
  context.beginDraw();  
  context.background(255);
  context.endDraw();
  
  if (zoomLevel <= maxZoomLevel) {
    context.loadPixels();
    for (int i = 0; i < data.length; i++) {
      for (int j = 0; j < data[i].length; j++) {    
        if (data[i][j] != null) {
          
          context.pixels[j * data.length + i] = color( max(0, 235 - 20 * scaleFactor * float(data[i][j].getAmountOfBases() )));
        }
      }  
    }
    context.updatePixels();
  } else {
    context.beginDraw();  
    int lineLength = 256 / data.length;
   
    for (int x = 0; x < data.length; x++) {
      for (int y = 0; y < data[x].length; y++) { 
        int amountofT = 0;
        int amountofC = 0;
        int amountofG = 0;
        int amountofA = 0;
        if (data[x][y] != null) {

          for (AcidBase a : data[x][y].getBases()) {
            if(a != null) {
              switch (a.base) {
                case 'c':
                  amountofC++;
                  break;
                case 'g':
                  amountofG++;
                  break;
                case 't':
                  amountofT++;
                  break;
                case 'a':
                  amountofA++;
                  break;
              }     
            }
          }
        }
        int sx = x * lineLength;       
        int sy = y * lineLength;
        // x+
        if (amountofC > 0) {
          int ex = x * lineLength - lineLength;
          int ey = y * lineLength;
          context.stroke( max(0, 215 - 40 * float(amountofC) ) );  
          context.line(sx,sy,ex,ey);
        } 
        // x- 
        if (amountofG > 0) {
          int ex = x * lineLength + lineLength;
          int ey = y * lineLength;
          context.stroke( max(0, 215 - 40 * float(amountofG) ) );  
          context.line(sx,sy,ex,ey);
        }// y+
        if (amountofA > 0) {
          int ex = x * lineLength;
          int ey = y * lineLength - lineLength;
          context.stroke( max(0, 215 - 40 * float(amountofA) ) );  
          context.line(sx,sy,ex,ey);
        } 
        // y- 
        if (amountofT > 0) {
          int ex = x * lineLength;
          int ey = y * lineLength + lineLength;
          context.stroke( max(0, 215 - 40 * float(amountofT) ) );  
          context.line(sx,sy,ex,ey);
        }     
      }
    }  
    context.endDraw();
  } 
  
  return context;
}


DataPoint[][] computeChromosome(
  ColorController cc, 
  DataPoint[][] data, 
  String pathToData, 
  String fileName, 
  PVector startPos, 
  float scaleFactor) {
 
  BufferedReader reader = createReader(pathToData + fileName);   
  boolean isFinished = false;
  int numLines = 0;
  int currentBaseNum = 0;
  String currentLine = "";
  PVector currentPos = new PVector(startPos.x, startPos.y);
  while (isFinished == false) {
    try {
      currentLine = reader.readLine();
      if (currentLine != null) {
        if (currentLine.charAt(0) != '>') {
          
          data = drawLine(currentLine, currentBaseNum, fileName, data, currentPos, cc, scaleFactor);
          numLines++;
          
        }  
      } else {
        isFinished = true;
        
      }
    } 
    catch (IOException e) {
      e.printStackTrace();      
    }   
  }
  reader = null;
  return data;  
}


DataPoint[][] drawLine(String currentLine, int currentBaseNum, String currentChrom, DataPoint[][] data, PVector currentPos, ColorController cc, float scaleFactor) { 
  
  for (int i = 0; i< currentLine.length(); i++) {
    char acidBase = currentLine.charAt(i);  
    
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
    
    if (currentPos.x >= 0 && currentPos.x < data.length) {
      if (currentPos.y >= 0 && currentPos.y < data[0].length) {
        int x = int(currentPos.x);
        int y = int(currentPos.y);
        
        if (data[x][y] == null) {
          data[x][y] = new DataPoint(x,y);
          data[x][y].addAcidBase(acidBase);
        }  else {
          data[x][y].addAcidBase(acidBase);
        }
      }  
    }  
  }
  return data;
}

void savePicture(float scaleFactor, String inputFileName, PGraphics context) {
  String dateString = 
    String.valueOf(year())+
    String.valueOf(month())+
    String.valueOf(day())+"_"+
    String.valueOf(hour())+"."+
    String.valueOf(minute());
    
  context.save(dateString+"_"+scaleFactor+"_"+inputFileName+".png");
 
}

//returns a rectangle defined by upper left corner and widht and height of a given 2D Datapoint array
DataPoint[][] getData(DataPoint[][] d, int ulX, int ulY, int w, int h) {
  //int w = d.length / int(pow(2, zoomLevel);
  DataPoint[][] newD = new DataPoint[w][h];
  
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < h; y++) {
      if ((ulX + x) < d.length && (ulY + y) < d[0].length) {
        
        if (d[ulX + x][ulY + y] != null) {
          newD[x][y] = new DataPoint(d[ulX + x][ulY + y]);
        }
      }
    }
  }  
  return newD;
}

// scales DOWN a 2D DataPointArray d to a DataPointArray of width x
// d must be quadratic!
// new width has to by a "power of 2 fraction" of original width! 
DataPoint[][] scaleData(DataPoint[][] d, int w, boolean scaleFullMetaData) {
  DataPoint[][] newD = new DataPoint[w][w];
  int sF = d.length / w;
  for (int x = 0; x < w; x++) {
    for (int y = 0; y < w; y++) {
      DataPoint[][] dP = getData(d, x * sF, y * sF, sF, sF);
      
      boolean notNull=false;
      for(DataPoint[] array : dP){
        for(DataPoint ddp : array){
          if(ddp!=null){
            notNull=true;
            break;
          }
        }
      }
      if (notNull == true) {
        newD[x][y] = new DataPoint(dP, x, y, scaleFullMetaData);
      }
    }
  } 
  return newD; 
}  


boolean isEmpty(DataPoint[][] dP) {
  
  for(DataPoint[] array : dP){
    for(DataPoint ddp : array){
      if(ddp!=null){
        return false;      
      }
    }
  }
  return true;

}
  


