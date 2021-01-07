//pshape tiling
PShape tile;
float rW = 40;
float rH = 40;
float[] patternA = {0.5, 1, 0.25, 0.75};
float[] patternB = {1, 0.5, 0.75, 0.25};
float[] patternC = {0.75, 0.25, 1, 0.5};
float[] patternD = {0.25, 0.75, 0.5, 1};

float [][] patternList = {patternA, patternB, patternC, patternD};

void setup() {
  tile = loadShape("tile.svg");
  
  
  size(800, 800);
  background(0);
  noFill();
  stroke(255);


  int patternIndex = 0;
  for (int j=0; j<height/rH; j++) {
    int t = 0;
    float[] targetPattern = patternList[patternIndex];
    patternIndex ++;
    if (patternIndex > patternList.length-1) {
      patternIndex = 0;
    }

    for (int i=0; i<width/rW; i++) {
      float v = targetPattern[t];
      float r = toQuadrant(v);
      drawSeed(i*rW, j*rH, r);
      t++;
      if (t>targetPattern.length-1) {
        t = 0;
      }
    }
  }
}
void draw() {
}

float toQuadrant(float v) {
  if (v <=0.25) {
    return 2*PI*0.25;
  } else if (v >0.25 && v<=0.5) {
    return  2*PI*0.5;
  } else if (v >0.5 && v<=0.75) {
    return  2*PI*0.75;
  } else {
    return 2*PI;
  }
}

void drawSeed(float x, float y, float r) {
  pushMatrix();
  translate(x+rW/2, y+rH/2);
  rotate(r);
  noFill();
  shape(tile,0,0,rW,rH);

  popMatrix();
}
