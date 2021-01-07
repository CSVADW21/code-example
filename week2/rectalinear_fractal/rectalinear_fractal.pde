//cross fractal

//variables for seed shape dimensions
float sqWidth = 50;
float lineWidth = sqWidth/8;
int count = 0;

void setup() {
  size(800,800);
  //set up stylistic properties
  background(0);
  stroke(255);
  strokeWeight(1);
  noFill();
  
  drawForm(width/2,height/2,300);
}

void draw() {
 
}

void drawForm(float x, float y, float s) {
  //draw the intial seed shape)
  drawSeed(x, y, s);
 
 //check the termination condition - is the scale greater than 30
  if(s > 30) {
    //if so, recurse 
    drawForm(x + s*0.65, y,s*0.65);
    drawForm(x - s*0.65, y,s*0.65);
    drawForm(x, y + s*0.65,s*0.65);
    drawForm(x, y - s*0.65,s*0.65);
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
  scale(s/100);

 //draw the central square
  rotate(radians(45));
  rectMode(CENTER);
  rect(0,0, sqWidth,sqWidth);
  pushMatrix();
  translate(sqWidth/2,sqWidth/2);
  line(0,0,lineWidth,lineWidth);
  popMatrix();
  
  
  //draw each line extending from the square  
  pushMatrix();
  translate(-sqWidth/2,sqWidth/2);
  line(0,0,-lineWidth,lineWidth);
  popMatrix();
  
  pushMatrix();
  translate(-sqWidth/2,-sqWidth/2);
  line(0,0,-lineWidth,-lineWidth);
  popMatrix();
  
    
  pushMatrix();
  translate(sqWidth/2,-sqWidth/2);
  line(0,0,lineWidth,-lineWidth);
  popMatrix();
 
  popMatrix();
  
  
}
