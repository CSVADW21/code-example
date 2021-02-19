

import wave.library.*;

Wave w, w2;
void setup() {
  size(800, 400, P2D);
  w = new Wave(this);
  w.setWave(80, 200, width);
  w.stroke(255, 0, 0);
  w.translate(new PVector(0, height/2));
  w.strokeWeight(5);
  w.resolution(50);


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
int num = 1;
void draw() {
  w.blur(0, 0, 0);
  w.drawWave();
  //w.translate(new PVector(move, 0));
  w.type(types[type_count]);
  if (frameCount%120 == 0) {
    type_count++;
    //println(num);
    switch (num) {
    case 0:
      println("0");
      w.stroke(255, 0, 0);
      break;
    case 1:
      println("1");

      w.stroke(0, 255, 0);
      break;
    case 2:
      println("2");
      w.stroke(0, 0, 255);
      break;
    }
    num++;
    if (num > 2) {
      num = 0;
    }
  }
  if (type_count >= types.length) {
    type_count=0;
  }
}