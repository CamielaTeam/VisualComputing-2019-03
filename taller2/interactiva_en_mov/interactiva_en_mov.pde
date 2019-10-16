PGraphics canvas;
int flag = 1;
int i = 0;
int flow = 1;
void setup(){
  size(600,400);
  canvas = createGraphics(600,400);
}

void draw(){
  canvas.beginDraw();
  canvas.background(255);
  canvas.fill(0);
  if(flag == 1){
    for(int i=0; i < 20; i++){
      canvas.rect(0+i*40,0,20,400);
    };
  }
  canvas.stroke(251,244,52);
  canvas.fill(251,244,52);
  canvas.rect(0+i*1.5,120,80,35);
  canvas.stroke(50,63,179);
  canvas.fill(50,63,179);
  canvas.rect(0+i*1.5,270,80,35);
  canvas.endDraw();
  if(i == 320){
    flow = 0;
  }
  if(i == 0){
    flow = 1;
  }
  if(flow == 1){
    i++;
  }else{
    i--;
  }
  
  image(canvas,0,0);
}

void mouseClicked(){
  if(flag == 1){
    flag = 0;
  }else{
    flag = 1;
  }
}        
