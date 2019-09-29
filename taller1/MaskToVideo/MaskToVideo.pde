import processing.video.Movie;
Movie mv;
PGraphics originalVideo;
PGraphics editedVideo;
PGraphics toPlotFrameRate;
boolean isPaused;
int count = 0;
float[][] mask = {{1,0,-1},{0,0,0},{-1,0,-1}};
int imgWidth = 300;
int imgHeight = 250;
 
void setup() {
  mv = new Movie(this, "un_video.mp4");
  mv.loop();
  size(900,250, P2D);
  frameRate(60);
 
  originalVideo = createGraphics(300, 250, P2D);
  editedVideo = createGraphics(300, 250, P2D);
  toPlotFrameRate = createGraphics(300, 250, P2D);
}
 
void draw() {
  originalVideo.beginDraw();
  originalVideo.image(mv, 0, 0, 300, 250);
  originalVideo.loadPixels();
  originalVideo.updatePixels();
  originalVideo.endDraw();
  
  editedVideo.beginDraw();
  editedVideo.loadPixels();
  editedVideo.pixels = applyConvolutionMask(createMatrixFromPixels(originalVideo.pixels, 300, 250), mask);
  editedVideo.updatePixels();
  editedVideo.endDraw();
  
  toPlotFrameRate.beginDraw();
  toPlotFrameRate.stroke(255);
  toPlotFrameRate.line(count,250,count, 250-frameRate);
  println(frameRate);
  count++;
  toPlotFrameRate.endDraw();
  
  image(originalVideo, 0, 0);
  image(editedVideo, 300, 0);
  image(toPlotFrameRate, 600,0);
 
}
 
void movieEvent(Movie m) {
  m.read();
}

//  Function to compute the convolution of two matrix
//  (Sum of point-to-point product)
int pointToPoint(float[][] mask, int[][] matrix) {
  float result = 0;
  int resultToReturn = 0;
  for (int i = 0; i < mask.length; i++) {
      for (int j = 0; j < mask[0].length; j++) {
          result += (float)matrix[i][j] * mask[i][j];  
      }
  }
  resultToReturn = round(result);
  return resultToReturn;
}

//  Function to create a pixel matrix from pixels array
int[][] createMatrixFromPixels(int[] pixels, int width, int height) {
  int[][] matrix = new int[width][height];
  int counter = 0;
  for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
          matrix[i][j] = pixels[counter];
          counter++;
      }
  }
  return matrix;
}

//  Function to apply a 3x3 convolution mask to a pixelMatrix, returns
//  the new pixel array
int[] applyConvolutionMask(int[][] pixelMatrix, float[][] mask) {
  int[] newPixelsArray = new int[pixelMatrix[0].length * pixelMatrix.length];
  int position = 0;
  for (int i = 0; i < pixelMatrix.length; i++) {
    for (int j = 0; j < pixelMatrix[0].length; j++) {
      if(i == 0 || j == 0 || i == pixelMatrix.length-1 || j == pixelMatrix.length-1 || i == pixelMatrix[0].length-1 || j == pixelMatrix[0].length-1){
        newPixelsArray[position] = pixelMatrix[i][j];
        position++;
      }else{
        int[][] currentPixels = new int[mask[0].length][mask.length];
      
        currentPixels[0][0] = pixelMatrix[i-1][j-1];
        currentPixels[0][1] = pixelMatrix[i-1][j];
        currentPixels[0][2] = pixelMatrix[i-1][j+1];
        currentPixels[1][0] = pixelMatrix[i][j-1];
        currentPixels[1][1] = pixelMatrix[i][j];
        currentPixels[1][2] = pixelMatrix[i][j+1];
        currentPixels[2][0] = pixelMatrix[i+1][j-1];
        currentPixels[2][1] = pixelMatrix[i+1][j];
        currentPixels[2][2] = pixelMatrix[i+1][j+1];
        
        newPixelsArray[position] = pointToPoint(mask, currentPixels);
        position++;
      }
      
    }
  }
  return newPixelsArray;
}

boolean isInArray(int [] array, int value){
  for(int i = 0; i < array.length; i++){
    if(array[i] == value){
      return true;
    }
  }
  return false;
}
