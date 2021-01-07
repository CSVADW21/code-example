float freq = 0.02;
float amp = 0.25;

void setup() {
  size(1000, 1000);
  background(0, 0, 0);
  int radNum = 6;
  float count = 8;


  for (float i=0; i<count; i++) {
    float scale;
    if (i >count/2) {
      scale = (1-i/count)*2;
    } else {
      scale = i/count*2;
    }
    println(scale);
    snowflake(width/count*i, height/2, scale, scale, 6);
  }
}


void draw() {
}


void snowflake(float x, float y, float scaleX, float scaleY, int radNum) {
  pushMatrix();
  translate(x, y);
  scale(scaleX, scaleY);
  for (int i=0; i<radNum; i++) {
    float sX = 1.0;
    if (i%2 == 0) {
      sX = -1.0;
    }
    drawRepeat(sX, 1, 2*PI/radNum*i);
  }

  popMatrix();
}

void drawRepeat(float scaleX, float scaleY, float rotation) {
  pushMatrix();
  scale(scaleX, scaleY);
  rotate(rotation);
  for (int i = 0; i<15; i++) {
    float y = 1+sin(float(i)*freq*PI)*amp/2;
    noFill();
    stroke(255);
    strokeWeight(0.25);
    drawShape(1, 2, y);
    drawShape(-1, 2, y);
    drawShape(-1.5, 1, y);
    drawShape(1.5, 1, y);
  }
  popMatrix();
}

void drawShape(float scaleX, float scaleY, float rotationVal) {
  pushMatrix();
  float mappedRotation = map(rotationVal, -1, 1, 0, 2*PI);
  scale(scaleX, scaleY);
  rotate(mappedRotation);

  ellipseMode(CORNER);
  ellipse(0, 0, 200*rotationVal, 100);
  popMatrix();
}
