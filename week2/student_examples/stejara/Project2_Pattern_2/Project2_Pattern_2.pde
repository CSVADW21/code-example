float rH = 80;
float rW = 80;
float angle = 0;
float sqWidth = 200;
float lineWidth = sqWidth/100;
int count = 0;

void setup() {
  size(800, 800);
  background(255, 0, 0, 100);
  noStroke();
  rectMode(CENTER);
  
  //grid shape
  for (int j = 0; j <= height/rH; j++) {
    for (int i = 0; i <= width/rW; i++) {
      
      if (i%2 == 0) {
        angle = radians(90);
      } else {
        angle = 0;
      }
      drawPattern(i*rW, j*rH, angle);
      pushMatrix();
      noFill();
      stroke(255, 100);
      rect(i*rW, j*rH, rW, rH);
      popMatrix();
    }
  }
  
  pushMatrix();
  stroke(255);
  drawForm(width/2,height/2,300);
  popMatrix();

}

//code taken and adapted from codeexamples/week2/truchet_tiling_3/
void drawPattern(float x, float y, float r) {
  pushMatrix();
  translate(x, y);
  fill(255, 100);
  ellipse(-rW/2, -rH/2, rW, rH);
  rect(-rW/2, -rH/2, rW/2, rH/2);
  popMatrix();
  pushMatrix();
  fill(0, 0, 255, 100);
  translate(x+rW/2, y+rH/2);
  rotate(r);
  triangle(-rW/2, -rH/2, rW/2, -rH/2, -rW/2, rH/2);
  popMatrix();
}
//this part of the code taken and adapted from codeexamples/week2/rectalinear_fractal/rectalinear_fractal.pde

void drawForm(float x, float y, float s) {
  //draw the intial seed shape)
  drawSeed(x, y, s);
 
 //check the termination condition - is the scale greater than 30
  if(s > 30) {
    //if so, recurse 
    drawForm(x + s*0.45, y,s*0.65);
    drawForm(x - s*0.45, y,s*0.65);
    drawForm(x, y + s*0.45,s*0.65);
    drawForm(x, y - s*0.45,s*0.65);
    count++;
    println(count);
  }
}

//seed 
void drawSeed(float x, float y, float s){
  //push into transformation matrix
  pushMatrix();
  //translate and scale according to function parameters
  translate(x,y);
  scale(s/200);

 //draw the central square
  rotate(radians(90));
  ellipse(0,0, sqWidth,sqWidth);
  pushMatrix();
  translate(sqWidth/2,sqWidth/2);
  ellipse(0,0,lineWidth,lineWidth);
  popMatrix();
  
  
  //draw each line extending from the square  
  pushMatrix();
  translate(-sqWidth/2,sqWidth/2);
  ellipse(0,0,-lineWidth,lineWidth);
  popMatrix();
  
  pushMatrix();
  translate(-sqWidth/2,-sqWidth/2);
  ellipse(0,0,-lineWidth,-lineWidth);
  popMatrix();
  
    
  pushMatrix();
  translate(sqWidth/2,-sqWidth/2);
  ellipse(0,0,lineWidth,-lineWidth);
  popMatrix();
 
  popMatrix();
}
