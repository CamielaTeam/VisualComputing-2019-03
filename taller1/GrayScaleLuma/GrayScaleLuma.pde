PGraphics original;
PGraphics edited;
PGraphics toPlotHistogram;
int imgWidth = 250;
int imgHeight = 250;
int toIdentifyFirstLine = 0;
int toIdentifySecondLine = 0;
int xFirstLine;
int xSecondLine;
void setup() {
  size(750, 250);
  original = createGraphics(imgWidth, imgHeight);
  edited = createGraphics(imgWidth, imgHeight);
  toPlotHistogram = createGraphics(imgWidth, imgHeight);
}

void draw() {
  PImage myImage = loadImage("imagen-chiquita.jpg");
  original.beginDraw();
  original.image(myImage,0,0,imgWidth,imgHeight);
  original.loadPixels();
  original.endDraw();
 
  edited.beginDraw();
  edited.loadPixels();
  edited.pixels = toGrayScaleLuma(original.pixels);
  edited.updatePixels();
  edited.endDraw();
 
  toPlotHistogram.beginDraw();
  toPlotHistogram.background(197,183,180);
  toPlotHistogram.stroke(255);
 
  int[] grayHistogram = makeHistogram(edited.pixels);
  for(int i = 0; i < grayHistogram.length; i++){
    int xMapped = int(map(i, 0, grayHistogram.length, 0, toPlotHistogram.width));
    int yMapped = int(map(grayHistogram[i], 0, max(grayHistogram), 0, toPlotHistogram.height));
    toPlotHistogram.line(xMapped, toPlotHistogram.height, xMapped, yMapped);
  }
  toPlotHistogram.stroke(204, 102, 0);
  toPlotHistogram.line(xFirstLine, 0, xFirstLine, imgHeight);
  toPlotHistogram.line(xSecondLine, 0, xSecondLine, imgHeight);

 
  if(mouseX-2*imgWidth>=0){
     edited.beginDraw();
     int map0to255c1 = int(map(xFirstLine, 0, imgWidth, 0, 255));
     int mapToGrayScalec1 = int(map(map0to255c1, 0, 255, min(edited.pixels), max(edited.pixels)));
     int map0to255c2 = int(map(xSecondLine, 0, imgWidth, 0, 255));
     int mapToGrayScalec2 = int(map(map0to255c2, 0, 255, min(edited.pixels), max(edited.pixels)));
     edited.pixels =  showJustSomePixels(edited.pixels, mapToGrayScalec1,mapToGrayScalec2, min(edited.pixels));
     edited.updatePixels();    
     edited.endDraw();
  }
  toPlotHistogram.endDraw();
  image(original,0,0);
  image(edited,imgWidth,0);
  image(toPlotHistogram,2*imgWidth,0);
}

//  Function to convert image to grayscale using luma
int [] toGrayScaleLuma(int [] pixelsToConvert){
  int [] pixelsConverted = new int [pixelsToConvert.length];
  for(int i = 0; i < pixelsToConvert.length; i++){
    float a = ((pixelsToConvert[i] >> 24)&0xFF);
    float r = 0.299*((pixelsToConvert[i] >> 16)&0xFF) ;
    float g = 0.587*((pixelsToConvert[i] >> 8)&0xFF) ;
    float b = 0.114*((pixelsToConvert[i]& 0xFF)) ;
    float luma = r + g + b;
    pixelsConverted[i] = color(luma,luma,luma);
  };
 
  return pixelsConverted;
}

boolean isInArray(int [] array, int value){
  for(int i = 0; i < array.length; i++){
    if(array[i] == value){
      return true;
    }
  }
  return false;
}

int[] makeHistogram(int[] imagePixels){
  int[] hist = new int[256];
  int max = max(imagePixels);
  int min = min(imagePixels);
  for(int i = 0; i < imagePixels.length; i++){
    int indexMapped = int(map(imagePixels[i], min, max, 0, 255 ));
    hist[indexMapped]++;
  }
  return hist;
}

int[] showJustSomePixels(int[] imagePixels, int colorValue1, int colorValue2 , int minColorToFill){
  int [] pixelsToReturn = new int[imagePixels.length];
  int minColor;
  int maxColor;
  if(colorValue1 <= colorValue2){
    minColor = colorValue1;
    maxColor = colorValue2;
  }else{
    minColor = colorValue2;
    maxColor = colorValue1;
  }
  for(int i = 0; i < imagePixels.length; i++){
    if(imagePixels[i] >= minColor && imagePixels[i]<= maxColor ){
      pixelsToReturn[i] = imagePixels[i];
    }else{
      pixelsToReturn[i] = minColorToFill;
    }
  }
  return pixelsToReturn;
}
void mouseClicked(){
  if(mouseX-2*imgWidth>=0){
    if(toIdentifyFirstLine == toIdentifySecondLine){
      xFirstLine = mouseX-2*imgWidth;
      toIdentifyFirstLine++;
    }else{
      xSecondLine = mouseX-2*imgWidth;
      toIdentifySecondLine++;
    }
  }
}
