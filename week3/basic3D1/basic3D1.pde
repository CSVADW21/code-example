

int resolution = 20;

float frequency = 0.1;
float amplitude = 1.0;
float vaseHeight = 500;
float phase = 0;



void setup() {
  size(1024, 768, P3D);
}


void draw() {
int rowNum = 50;

  background(0);
  lights();
  pushMatrix();
  translate(width / 2, height / 2 , -100);
  fill(255);
  stroke(0,0,255);
 
 rotateY((float)(frameCount * Math.PI / 400));


  beginShape();
  vertex(-100, -100);
  vertex(100, -100);
  vertex(100, 100);
  vertex(-100, 100);
  endShape(CLOSE);

  popMatrix();
}
