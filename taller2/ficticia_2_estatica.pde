PGraphics canvas;
void setup(){
  size(500,500);
  canvas = createGraphics(500,500);
}

void draw(){
  canvas.beginDraw();
  canvas.background(255,255,255);
  canvas.stroke(0);
  canvas.fill(0);
  for(int i = 0; i < 500; i+=50){
    for(int j = 0; j < 500; j+=50){
     canvas.square(i,j,40);
    } 
  }
  canvas.endDraw();
  image(canvas,0,0);
}
