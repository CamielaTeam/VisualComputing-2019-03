PGraphics canvas;
int random = 0;
int count = 0;
void setup(){
  size(500,500);
  canvas = createGraphics(500,500);
}

void draw(){
  canvas.beginDraw();
  canvas.background(125);
  canvas.fill(0);
  canvas.rect(0,0,250,340);
  canvas.fill(251,125,52);
  canvas.rect(0,0,230,320);
  canvas.fill(0);
  canvas.circle(430,430,20);
  canvas.fill(125);
  canvas.stroke(125);
  canvas.rect(0,50*random, 230, 55);
  canvas.endDraw();
  if(count % 8 == 0){
    random = int(random(1,5));
  }
  
  count++;
  image(canvas,0,0);
}        
