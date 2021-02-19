import wave.library.*;

Wave w, w2, w3, w4;
void setup() {
  size(600, 600,P2D);
  
  w = new Wave(this);
  w.setWave(80, 200, 300);
  w.stroke(255, 0, 0);
  w.translate(new PVector(100, height/2));
  w.strokeWeight(5);
  w.resolution(1);
  w.rotate(90);

  w2 = new Wave(this);
  w2.setWave(40, 75, 500);
  w2.stroke(0,255,0);
  w2.translate(new PVector(0, 100));
  w2.strokeWeight(10);
  w2.type("quads");
  w2.resolution(10);
  
  w3 = new Wave(this);
  w3.setWave(40, 75, 500);
  w3.stroke(0,0,255);
  w3.translate(new PVector(width, 0));
  w3.rotate(90+45);
  w3.strokeWeight(10);
  w3.resolution(30);
  
  w4 = new Wave(this);
  w4.setWave(40, 50, width-100);
  w4.stroke(255,255,255);
  w4.translate(new PVector(width, height-100));
  w4.strokeWeight(10);
  w4.resolution(20);
  w4.type("points");
  w4.rotate(180);
  
}
void draw() {
  w.blur(0,0,0);
  w.drawWave();
  w2.drawWave();
  w3.drawWave();
  w4.drawWave();
}