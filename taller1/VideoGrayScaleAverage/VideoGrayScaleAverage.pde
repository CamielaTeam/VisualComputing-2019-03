import processing.video.Movie;
Movie mv;
PGraphics originalVideo;
PGraphics editedVideo;
PGraphics toPlotFrameRate;
boolean isPaused;
int count = 0;
 
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
  editedVideo.pixels = toGrayScaleAverage(originalVideo.pixels);
  editedVideo.updatePixels();
  editedVideo.endDraw();
  
  toPlotFrameRate.beginDraw();
  toPlotFrameRate.stroke(255);
  toPlotFrameRate.line(count,250,count, 250-frameRate);
  count++;
  toPlotFrameRate.endDraw();
  
  image(originalVideo, 0, 0);
  image(editedVideo, 300, 0);
  image(toPlotFrameRate, 600,0);
 
}
 
void movieEvent(Movie m) {
  m.read();
}

//  Function to convert image to grayscale using rgb average
int [] toGrayScaleAverage(int [] pixelsToConvert){
  int [] pixelsConverted = new int [pixelsToConvert.length];
  for(int i = 0; i < pixelsToConvert.length; i++){
    int a = (pixelsToConvert[i] >> 24)&0xFF;
    int r = (pixelsToConvert[i] >> 16)&0xFF;
    int g = (pixelsToConvert[i] >> 8)&0xFF ;
    int b = (pixelsToConvert[i]& 0xFF) ;
    int average = (r+g+b)/3;
    pixelsConverted[i] = color(average, average,average);
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
