import nub.primitives.*;
import nub.core.*;
import nub.processing.*;

// 1. Nub objects
Scene scene;
Node node;
Vector v1, v2, v3, prueba;
// timing
TimingTask spinningTask;
boolean yDirection;
// scaling is a power of 2
int n = 4;

// 2. Hints
boolean triangleHint = true;
boolean gridHint = true;
boolean debug = true;
boolean shadeHint = false;

// 3. Use FX2D, JAVA2D, P2D or P3D
String renderer = P2D;

// 4. Window dimension
int dim = 10;

void settings() {
  size(int(pow(2, dim)), int(pow(2, dim)), renderer);
}

void setup() {
  rectMode(CENTER);
  scene = new Scene(this);
  if (scene.is3D())
    scene.setType(Scene.Type.ORTHOGRAPHIC);
  scene.setRadius(width/2);
  scene.fit(1);

  // not really needed here but create a spinning task
  // just to illustrate some nub timing features. For
  // example, to see how 3D spinning from the horizon
  // (no bias from above nor from below) induces movement
  // on the node instance (the one used to represent
  // onscreen pixels): upwards or backwards (or to the left
  // vs to the right)?
  // Press ' ' to play it
  // Press 'y' to change the spinning axes defined in the
  // world system.
  spinningTask = new TimingTask(scene) {
    @Override
    public void execute() {
      scene.eye().orbit(scene.is2D() ? new Vector(0, 0, 1) :
        yDirection ? new Vector(0, 1, 0) : new Vector(1, 0, 0), PI / 100);
    }
  };

  node = new Node();
  node.setScaling(width/pow(2, n));

  // init the triangle that's gonna be rasterized
  randomizeTriangle();
}

void draw() {
  background(0);
  stroke(0, 255, 0);
  if (gridHint)
    scene.drawGrid(scene.radius(), (int)pow(2, n));
  if (triangleHint)
    drawTriangleHint();
  push();
  scene.applyTransformation(node);
  triangleRaster();
  pop();
}

// Implement this function to rasterize the triangle.
// Coordinates are given in the node system which has a dimension of 2^n
void triangleRaster() {
  // node.location converts points from world to node
  // here we convert v1 to illustrate the idea
  if (debug) {
    push();
    noStroke();
    for ( int i = -512; i <= 512; i = i+64 ) {
      for ( int j = -512; j <= 512; j = j+64 ) {
        prueba = new Vector(i, j);
        if(edgeFunction(v1, v2, prueba) && edgeFunction(v2, v3, prueba) && edgeFunction(v3, v1, prueba)){
        float [] bcMatrix = baricentricCoordinates(v1, v2, v3, prueba);
        int blue= int(bcMatrix[0]*255);
        int red= int(bcMatrix[1]*255);
        int green= int(bcMatrix[2]*255);
        fill(red, green, blue, 125);
        square(round(node.location(prueba).x()), round(node.location(prueba).y()), 1);
        }
      }
    }
    pop();
  }
}

void randomizeTriangle() {
  int low = -width/2;
  int high = width/2;
  int determinant = 1;
  while(determinant>0){
  v1 = new Vector(random(low, high), random(low, high));
  System.out.println("v1x " +round(v1.x()));
  System.out.println("v1y " +round(v1.y()));
  v2 = new Vector(random(low, high), random(low, high));
    System.out.println("v2x " +round(v2.x()));
  System.out.println("v2y " +round(v2.y()));
  v3 = new Vector(random(low, high), random(low, high));
  determinant = int(v1.x()*(v2.y()-v3.y())-v2.x()*(v1.y()-v3.y())+v3.x()*(v1.y()-v2.y()));
  }

}

boolean edgeFunction(Vector a, Vector b, Vector p ){
  return ((p.x() - a.x()) * (b.y() - a.y()) - (p.y()  - a.y()) * (b.x() - a.x()) >= 0);
}



float[] baricentricCoordinates(Vector a, Vector b, Vector c, Vector p) {
  float fabp=(a.y()-b.y())*p.x()+(b.x()-a.x())*p.y()+a.x()*b.y()-b.x()*a.y();
  float fab=(a.y()-b.y())*c.x()+(b.x()-a.x())*c.y()+a.x()*b.y()-b.x()*a.y();
  float bc_ab=fabp/fab;
  
  float fbcp=(b.y()-c.y())*p.x()+(c.x()-b.x())*p.y()+b.x()*c.y()-c.x()*b.y();
  float fbc=(b.y()-c.y())*a.x()+(c.x()-b.x())*a.y()+b.x()*c.y()-c.x()*b.y();
  float bc_bc=fbcp/fbc;
  
  float fcap=(c.y()-a.y())*p.x()+(a.x()-c.x())*p.y()+c.x()*a.y()-a.x()*c.y();
  float fca=(c.y()-a.y())*b.x()+(a.x()-c.x())*b.y()+c.x()*a.y()-a.x()*c.y();
  float bc_ca=fcap/fca;
  
  float[] matrix = new float[3];
  matrix[0] = bc_ab;
  matrix[1] = bc_bc;
  matrix[2]= bc_ca;
  
  return matrix;
}

void drawTriangleHint() {

  push();
  if(shadeHint)
    noStroke();
  else {
    strokeWeight(2);
    noFill();
  }
  beginShape(TRIANGLES);
  if(shadeHint)
    fill(255, 0, 0);
  else
  stroke(255, 0, 0);
  vertex(v1.x(), v1.y());
  if(shadeHint)
    fill(0, 255, 0);
  else
    stroke(0, 255, 0);
  vertex(v2.x(), v2.y());
  if(shadeHint)
    fill(0, 0, 255);
  else
    stroke(0, 0, 255);
  vertex(v3.x(), v3.y());
  endShape();

  strokeWeight(5);
  stroke(255, 0, 0);
  point(v1.x(), v1.y());
  stroke(0, 255, 0);
  point(v2.x(), v2.y());
  stroke(0, 0, 255);
  point(v3.x(), v3.y());

  pop();
}

void keyPressed() {
  if (key == 'g')
    gridHint = !gridHint;
  if (key == 't')
    triangleHint = !triangleHint;
  if (key == 's')
    shadeHint = !shadeHint;
  if (key == 'd')
    debug = !debug;
  if (key == '+') {
    n = n < 7 ? n+1 : 2;
    node.setScaling(width/pow( 2, n));
  }
  if (key == '-') {
    n = n >2 ? n-1 : 7;
    node.setScaling(width/pow( 2, n));
  }
  if (key == 'r')
    randomizeTriangle();
  if (key == ' ')
    if (spinningTask.isActive())
      spinningTask.stop();
    else
      spinningTask.run();
  if (key == 'y')
    yDirection = !yDirection;
}
