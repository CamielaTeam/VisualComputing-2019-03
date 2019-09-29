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
  editedVideo.pixels = toGrayScaleLuma(originalVideo.pixels);
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
