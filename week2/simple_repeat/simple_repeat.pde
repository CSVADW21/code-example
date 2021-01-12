float freq = 0.02;
float amp = 0.25;
  
void setup(){
  size(1000,1000);
  background(0,0,0);
  
  for(int i = 0; i<15; i++){
     float y = 1+sin(float(i)*freq*PI)*amp/2;
     noFill();
     stroke(255);
     strokeWeight(0.15);
     drawShape(1,2,y);
     drawShape(-1,2,y);
     drawShape(-1,-2,y);
     drawShape(1,-2,y);
  }
}


void draw(){
  
}

void drawShape(float scaleX, float scaleY,float rotationVal){
  pushMatrix(); // saves the current coordinate system to the stack (enables controlling the scope of matrix transformations)
  translate(width/2,height/2); // translates the origin of the coordinate system to the center of the screen
  float mappedRotation = map(rotationVal,-1,1,0,2*PI); //use mapping function to map rotation between 0 and 2PI - rotation is in radians
  scale(scaleX,scaleY); // multiplies vertices by a scalar to adjust size. Objects always scale from their relative origin to the coordinate system.
  rotate(mappedRotation); // rotates the coordinate system around the translated origin
  ellipseMode(CORNER);
  ellipse(0, 0, 200*rotationVal,100);
  popMatrix(); // restores the prior, pre-translated coordinate system (origin is back to 0, 0)
}
