PGraphics canvas;
void setup(){
  size(500,500);
  canvas = createGraphics(500,500);
}

void draw(){
  canvas.beginDraw();
  canvas.background(255,255,255);
  canvas.stroke(0);
  canvas.strokeWeight(7);
  canvas.line(0,153,500,153);
  canvas.line(0,347,500,347);
  canvas.strokeWeight(4);
  for(int i = 0; i < 500; i+=50){
    canvas.line(250,250,i,0);
    canvas.line(250,250,0,i);
    canvas.line(250,250,500,i);
    canvas.line(250,250,i,500);
  }
  canvas.endDraw();
  image(canvas,0,0);
}
