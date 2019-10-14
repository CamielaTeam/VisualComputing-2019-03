PGraphics canvas;
float counter = 0;
void setup(){
  size(500,500);
  canvas = createGraphics(500,500);
}

void draw(){
  canvas.beginDraw();
  canvas.background(200,200,200);
  canvas.strokeWeight(3);
  canvas.stroke(0);
  canvas.line(250,245,250,255);
  canvas.line(245,250,255,250);
  
  canvas.stroke(250,0,235);
  canvas.fill(250,0,235);
  
  if(int(floor(counter))%12 != 0){
    //1
    canvas.circle(250,100,30);
  }
  if(int(floor(counter))%12 != 1){
    //2
    canvas.circle(333,125,30);
  }
  if(int(floor(counter))%12 != 2){
    //3
    canvas.circle(385.2,185,30);
  }
  if(int(floor(counter))%12 != 3){
    //4
    canvas.circle(400,250,30);
  }
  if(int(floor(counter))%12 != 4){
    //5
    canvas.circle(385,315.4,30);
  }
  if(int(floor(counter))%12 != 5){
    //6
    canvas.circle(333,375,30);
  }
  if(int(floor(counter))%12 != 6){
    //7
    canvas.circle(250,400,30);
  }
  if(int(floor(counter))%12 != 7){
    //8
    canvas.circle(167,375,30);
  }
  if(int(floor(counter))%12 != 8){
    //9
    canvas.circle(115,315.4,30);
  }
  if(int(floor(counter))%12 != 9){
    //10
    canvas.circle(100,250,30);
  }
  if(int(floor(counter))%12 != 10){
    //11
    canvas.circle(115,185,30);
  }
  if(int(floor(counter))%12 != 11){
    //12
    canvas.circle(167,125,30);
  }
  counter=counter+0.1;
  canvas.endDraw();
  image(canvas,0,0);
}
