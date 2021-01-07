  float freq = 0.02;
  float amp = 0.25;
  
void setup(){
  size(1000,1000);
  background(0,0,0);
int radNum = 6;
for(int i=0;i<radNum;i++){
  float scaleX = 1.0;
  if (i%2==0){
    scaleX = -1.0;
  }
  drawRepeat(scaleX,1,2*PI/radNum*i);
}



  
}


void draw(){
  
}


void drawRepeat(float scaleX, float scaleY, float rotation){
  pushMatrix();
  translate(width/2,height/2);
  scale(scaleX,scaleY);
  rotate(rotation);
  for(int i = 0; i<15; i++){
     float y = 1+sin(float(i)*freq*PI)*amp/2;
     noFill();
     stroke(255);
     strokeWeight(0.15);
     drawShape(1,2,y);
     drawShape(-1,2,y);
      drawShape(-1.5,1,y);drawShape(1.5,1,y);
    //drawShape(-1,1,10*i,);
    
  }
  popMatrix();
}

void drawShape(float scaleX, float scaleY,float rotationVal){
  pushMatrix();
  float mappedRotation = map(rotationVal,-1,1,0,2*PI);
  println(mappedRotation);
  scale(scaleX,scaleY);
    rotate(mappedRotation);

  ellipseMode(CORNER);
  ellipse(0, 0, 200*rotationVal,100);
  popMatrix();
}

/*void drawShape(float scaleX, float scaleY,float x1, float y1, float x2, float y2, float x3, float y3){
  pushMatrix();
  translate(width/2,height/2);
  scale(scaleX,scaleY);
  quad(0, 0, x1,y1,x2,y2,x3,y3);
  popMatrix();
}*/
