import wave.library.*;

Wave w, w2, w3, w4;
void setup() {
  size(600, 300,P2D);
  w = new Wave(this);
  w.setWave(50, 200, width);
  w.stroke(255, 255, 255);
  w.translate(new PVector(0, height/2));
  w.strokeWeight(5);
  w.resolution(5);
  
  w4 = new Wave(this);
  w4.setWave(40, 50, width);
  w4.stroke(0,0,0);
  w4.translate(new PVector(0, height/2));
  w4.strokeWeight(10);
  w4.resolution(20);
  w4.type("points");
  background(0);
}
int count = 0;
int direction = 1;
void draw() {
  w.drawWave();
if (count > 255 || count < 0){
  direction *= -1;
}
  w4.drawWave();
  w4.stroke(count,0,0);
  count+= direction;
  //w4.sound();
}