
import wave.library.*;

Wave w, w2;
void setup() {
  size(600, 600, P2D);
  w = new Wave(this);
  w.setWave(80, 200, height);
  w.stroke(255, 0, 0);
  w.translate(new PVector(0, 0));
  w.strokeWeight(5);
  w.resolution(50);
  w.rotate(90);


  w2 = new Wave(this);
  w2.setWave(40, 75, 300);
  w2.stroke(0, 0, 255);
  w2.translate(new PVector(width/2, height/2));
  w2.strokeWeight(15);
  w2.resolution(10);
}
String types[] = {"points", "lines", "triangles", "triangle_strip", "quads", "quad_strip"};

int count = 0;
int move = 0;
int type_count;
void draw() {
  w.blur(0, 0, 0);
  w.drawWave();
  w.translate(new PVector(move, 0));
  w.type(types[type_count]);
  w2.rotate(count);
  if (move>width) {
    move = 0;
  }
  if (frameCount%60 == 0) {
    type_count++;
  }
  if (type_count >= types.length) {
    type_count=0;
  }
  move++;
  count++;
  w2.drawWave();
  w2.resolution((type_count+1)*10);

  w.sound();
  w2.sound();
}