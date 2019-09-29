PGraphics original;
PGraphics edited;
float[][] mask = {{-1,-1,-1},{-1,8,-1},{-1,-1,-1}};
int imgWidth = 250;
int imgHeight = 250;
void setup() {
  size(500, 250);
  original = createGraphics(imgWidth, imgHeight);
  edited = createGraphics(imgWidth, imgHeight);
}

void draw() {
  PImage myImage = loadImage("imagen-chiquita.jpg");
  original.beginDraw();
  original.image(myImage,0,0,imgWidth,imgHeight);
  original.loadPixels();
  original.endDraw();
 
  edited.beginDraw();
  edited.loadPixels();
  edited.pixels = applyConvolutionMask(createMatrixFromPixels(original.pixels,imgWidth,imgHeight), mask);
  edited.updatePixels();
  edited.endDraw();
  image(original,0,0);
  image(edited,imgWidth,0);
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
