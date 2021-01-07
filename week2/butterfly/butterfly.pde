PShape [] topShapes;
PShape [] bottomShapes;

void setup(){
  size(1000,1000);
  background(100,100,100);
  topShapes = loadShapes("top");
  bottomShapes = loadShapes("bottom");

  int count = 40;
  drawWing(topShapes,1.2,1.2,radians(-35));
  drawWing(topShapes,-1.2,1.2,radians(-35));
  drawWing(bottomShapes,1,1,radians(35));
  drawWing(bottomShapes,-1,1,radians(35));

  drawBody();
}

void draw(){
  
}




PShape[] loadShapes(String type){
  PShape[] shapes = new PShape[3];

  for (int i=0; i<shapes.length; i++){
    PShape shape = loadShape(type+"/wing"+(i)+".svg");
    shapes[i] = shape;
  }
  
  return shapes;
}


void drawBody(){
  pushMatrix();
  translate(width/2,height/2);
  ellipseMode(CENTER);
  fill(0);
  noStroke();
  ellipse(0,-40,25,25);
  ellipse(0,110,25,300);
  popMatrix();
  
}

void drawWing(PShape[] shapeArray, float scaleX, float scaleY, float rotation){
  pushMatrix();
translate(width/2,height/2);
scale(scaleX,scaleY);
rotate(rotation);
float t = 0;
for(int i = 0; i<shapeArray.length; i++){
     t++;
     float r = i+1;
    float mappedR = map(r,0,shapeArray.length,0,radians(25));
    float scale = map(shapeArray.length-i,0,shapeArray.length-1,0.75,1.0);
    println(r,t, degrees(mappedR));
     noFill();
     stroke(255);
     strokeWeight(0.25);
     PShape shape = shapeArray[i];
     drawShape(shape,scale,scale,mappedR);   
  }
  
  
  popMatrix();
}

void drawShape(PShape shape, float scaleX, float scaleY, float rotation){
  pushMatrix();
  rotate(rotation);
  scale(scaleX,scaleY);
  shape(shape,0,0);
  popMatrix();
}
