
void setup() {
  size(600,600);
}

// Ancho total 438
// Altura total 376
// centro  219, 188

void draw() {
  background(250);
  translate(300, 300);
  fill(168,122,187);
  stroke(66,68,101);
  strokeWeight(2);
  beginShape();
  vertex(20, -188); // 1
  vertex(-29, -188); // 2
  vertex(-219, 151); // 3
  vertex(123, 147); // 4
  vertex(102, 107); // 5
  vertex(-151, 107); // 6
  endShape(CLOSE);
  
  fill(150);
  beginShape();
  fill(162,198,230);
  vertex(21, -188); // punta de arriba
  vertex(-151, 107); // punta extrema izquierda
  vertex(-102, 107); // punta media izquierda
  vertex(21, -105); // punta media arriba
  vertex(195, 186); // ok
  vertex(217, 147); // 
  endShape(CLOSE);
  
  fill(90,120,176);
  beginShape();
  vertex(21, -104); // punta extrema arriba
  vertex(194, 186); // punta extrema derecha
  vertex(-199, 188); // punta abajo izquierda
  vertex(-219, 151); // punta derecha media abajo
  vertex(123, 147); // esquina media derecha abajo
  vertex(-5, -60); // 
  endShape(CLOSE);
}
