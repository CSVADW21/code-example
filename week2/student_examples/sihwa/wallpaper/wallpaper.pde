// Create a repeating Wallpaper
//
// Sihwa Park
// Media Arts and Technology
// sihwapark@ucsb.edu
// 10/07/2019
//

float rW = 40;
float rH = 40;
float[] patternA = {0, 0.25, 0.5, 0.75};
float[] patternB = {0.75, 0.5, 0.25, 0.0};
float[][] patterns = {patternA, patternB};
color[] colorPattern = {#E54F4F, #F0A0A0, #86D6D5, #7BA59A};
color negativeSpaceColor = #FAF1C0;
boolean wavy = true;

void setup() {

  size(1000, 1000);
  background(0);

  drawPattern();
  //save(int(width/rW) + "x" + int(height/rH) + "_grid.png");
}

void drawPattern() {
  int patternIndex = 0;
  for (int j = 0; j < height / rH; j++) {
    patternIndex = (j % 4 == 0)? 1 : 0;

    for (int i = 0; i < width / rW; i++) {
      int patternType = (i % 3 == 0)? 0 : 1;
      float r = degreeRatio(patterns[patternType][patternIndex]);
      drawSeed(i * rW, j * rH, r, patternIndex);
      patternIndex++;
      patternIndex %= patterns[patternType].length;
    }
  }
}

void draw() {
}

float degreeRatio(float r) {
  return r * TWO_PI;
}



void drawSeed(float x, float y, float r, int cIndex) {
  float cX = x + rW / 2;
  float cY = y + rH / 2;
  
  pushMatrix();
  translate(cX, cY);
  rotate(r);
  
  stroke(255);
  fill(colorPattern[cIndex]);
  rectMode(CENTER);
  rect(0, 0, rW, rH);

  fill(negativeSpaceColor);
  
  float s = 1.0;
  float alpha = sin(TWO_PI * (cX / width) + TWO_PI * (cY / height));
  if (wavy) s = 0.6 + 0.4 * alpha;
  noStroke();
  triangle(-rW/2, -rH/2, -rW/2 + rW/2 * s, -rH/2, -rW/2, -rH / 2 + rH/2 * s);
  triangle(rW/2, rH/2, rW/2 - rW/2 * s, rH/2, rW/2, rH / 2 - rH/2 * s);

  if (cIndex % 3 == 0) circle(rW * 0.3, -rH * 0.3, rW * 0.15);
  if (cIndex == 0) rect(-rW * 0.33, rH * 0.33, rW * 0.15, rH * 0.15);

  if (alpha < 0.5) {
    stroke(negativeSpaceColor);
    line(-rW * 0.125, 0, rW * 0.125, 0);
    line(0, -rH * 0.125, 0, rH * 0.125);
  }

  popMatrix();
}

void keyPressed() {
  if (key == ' ') {
    wavy = !wavy;
    drawPattern();
  }
}
