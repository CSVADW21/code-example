PVector p2;
PVector p1;
float stepSize = 20;
float angle;
float strokeWidth = 0.3;

void setup() {
  size(600, 600);
  //start vector with origin in the center of the screen
  p2 = new PVector(width/2, height/2);
  p1 = p2.copy();
  smooth();
  //frameRate(4);
  background(0);
}

void draw() {
  //fill(0, 10);
  //noStroke();
  //rect(0, 0, width, height);

  
  //pick a random angle
  angle = random(0, 2*PI);
  float constrainedAngle = toQuadrant(angle);
  println(degrees(angle),degrees(constrainedAngle));
  PVector aV = new PVector(cos(constrainedAngle) * stepSize,sin(constrainedAngle) * stepSize);
  p2.add(aV);

  // offscreen wrap
  if (p2.x<-10) p2.x=p1.x=width+10;
  if (p2.x>width+10) p2.x=p1.x=-10;
  if (p2.y<-10) p2.y=p1.y=height+10;
  if (p2.y>height+10) p2.y=p1.y=-10;

  stroke(255);
  strokeWeight(3);
  
  //draw line from p
  line(p1.x, p1.y, p2.x, p2.y);

  p1.set(p2);
}

float toQuadrant(float v) {
  if (v <= 2*PI*0.25) {
    return 2*PI*0.25;
  } else if (v >2*PI*0.25 && v<=2*PI*0.5) {
    return  2*PI*0.5;
  } else if (v >2*PI*0.5 && v<=2*PI*0.75) {
    return  2*PI*0.75;
  } else {
    return 2*PI;
  }
}
/*
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
*/
