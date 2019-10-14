PGraphics canvas;
int flag = 1;
int jump = 10;
void setup(){
  size(500,400);
  canvas = createGraphics(500,400);
}

void draw(){
  canvas.beginDraw();
  canvas.background(255);
  canvas.strokeWeight(3);
  canvas.stroke(150);
  for(int i=0; i<8; i++){
    canvas.line(0,50*i, 500,50*i);
    if(flag == 1){
      canvas.fill(0);
      for(int j=0; j<7; j++){
        if(i == 0 || i == 4){
          canvas.square(i+jump+j*100,i*50, 50);
        }
        if(i == 1 || i == 3 || i == 5 || i == 7){
          canvas.square(i+2*jump+j*100,i*50, 50);
        }
        if(i == 2 || i == 6){
          canvas.square(i+3*jump+j*100,i*50, 50);
        }
        
      }
    }
  }
  canvas.stroke(250,0,235);
  canvas.fill(250,0,235);
 
  canvas.endDraw();
  image(canvas,0,0);
}

void mouseClicked(){
  if(flag == 1){
    flag = 0;
  }else{
    flag = 1;
  }
}        
