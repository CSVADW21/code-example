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
  pushMatrix();
  translate(width/2,height/2);
  //use mapping function to map rotation between 0 and 2PI - rotation is in radians
  float mappedRotation = map(rotationVal,-1,1,0,2*PI);
  scale(scaleX,scaleY);
  rotate(mappedRotation);
  ellipseMode(CORNER);
  ellipse(0, 0, 200*rotationVal,100);
  popMatrix();
}
