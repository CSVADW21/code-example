float freq = 0.02;
float amp = 0.25;

void setup() {
  size(1000, 1000);
  background(0, 0, 0);
  int radNum = 6;
  for (int i=0; i<radNum; i++) {
    float scaleX = 1.0;
    if (i%2==0) { // execute every time i is even
      scaleX = -1.0;
    }
    drawRepeat(scaleX, 1, 2*PI/radNum*i);
  }
}


void draw() {
}


void drawRepeat(float scaleX, float scaleY, float rotation) {
  pushMatrix();  // saves the current coordinate system to the stack (enables controlling the scope of matrix transformations)
  translate(width/2, height/2); // translates the origin of the coordinate system to the center of the screen
  scale(scaleX, scaleY); // multiplies vertices by a scalar to adjust size. Objects always scale from their relative origin to the coordinate system.
  rotate(rotation); // rotates the coordinate system around the translated origin
  for (int i = 0; i<15; i++) {
    float y = 1+sin(float(i)*freq*PI)*amp/2;
    noFill();
    stroke(255);
    strokeWeight(0.15);
    drawShape(1, 2, y);
    drawShape(-1, 2, y);
    drawShape(-1.5, 1, y);
    drawShape(1.5, 1, y);
    //drawShape(-1,1,10*i,);
  }
  popMatrix(); // restores the prior, pre-translated coordinate system  (origin is back to 0, 0)
}

void drawShape(float scaleX, float scaleY, float rotationVal) {
  pushMatrix(); // saves the current coordinate system to the stack (enables controlling the scope of matrix transformations)
  float mappedRotation = map(rotationVal, -1, 1, 0, 2*PI);
  println(mappedRotation);
  scale(scaleX, scaleY); // multiplies vertices by a scalar to adjust size. Objects always scale from their relative origin to the coordinate system.
  rotate(mappedRotation); // rotates the coordinate system around the translated origin

  ellipseMode(CORNER);
  ellipse(0, 0, 200*rotationVal, 100);
  popMatrix(); // restores the prior, pre-translated coordinate system  (origin is back to 0, 0)
}

/*void drawShape(float scaleX, float scaleY,float x1, float y1, float x2, float y2, float x3, float y3){
 pushMatrix(); // saves the current coordinate system to the stack (enables controlling the scope of matrix transformations)
 translate(width/2,height/2); // translates the origin of the coordinate system to the center of the screen
 scale(scaleX,scaleY); // multiplies vertices by a scalar to adjust size. Objects always scale from their relative origin to the coordinate system.
 quad(0, 0, x1,y1,x2,y2,x3,y3);
 popMatrix(); // restores the prior, pre-translated coordinate system  (origin is back to 0, 0)
}*/
