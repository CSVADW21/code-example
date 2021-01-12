//pshape tiling
PShape skull;
float rW = 30;
float rH = 30;
float[] patternA = {0.5, 1, 0.25, 0.75};
float[] patternB = {1, 0.5, 0.75, 0.25};
float[] patternC = {0.75, 0.25, 1, 0.5};
float[] patternD = {0.25, 0.75, 0.5, 1};

float [][] patternList = {patternA, patternB, patternC, patternD};

void setup() {
  skull = loadShape("tile.svg");
  
  
  size(800, 800);
  background(255);
  noFill();
  stroke(0);


  int patternIndex = 0;
  for (int j=0; j<width/rH; j++) {
    int t = 0;
    float[] targetPattern = patternList[patternIndex];
    patternIndex ++;
    if (patternIndex > patternList.length-1) {
      patternIndex = 0;
    }

    for (int i=0; i<height/rW; i++) {
      float v = targetPattern[t];
      float r = toQuadrant(v);
      drawSeed(i*rW, j*rH, r);
      t++;
      if (t>targetPattern.length-1) {
        t = 0;
      }
    }
  }
  save("scale10.png");
}
void draw() {
}

int getRandomColor() {
  return (int)Math.floor(Math.random() * Math.floor(255));
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
  skull.disableStyle();
  int fillColorR = getRandomColor();
  int fillColorB = getRandomColor();
  int fillColorG = getRandomColor();
  fill(fillColorR, fillColorB, fillColorG);
  shape(skull,0,0,rW,rH);
  // creating random strokes
  line(rW/2 + random(8+r),-rH/2 + random(8+r),-rW/2 + random(8+r),rH/2 + random(8+r));
  line(rW/2 - r,-rH/2 - r,-rW/2 - r,rH/2 - r);
  skull.enableStyle();
  popMatrix();
}
