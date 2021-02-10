// Josef Albers Color Relativity 1 Example from Code as Creative Medium
// What are the conditions where three colors look like 4? 
// Pressing the spacebar changes the two background colors. 
// Presssing the mouse changes the two circle colors.

color left; 
color right;
color circle;

void setup() {
  size(500, 500);
  background(255);
  left = color(random(0, 255), random(0, 255), random(0, 255));
  right = color(random(0, 255), random(0, 255), random(0, 255));
  circle = color(random(0, 255), random(0, 255), random(0, 255));
  noStroke();
}

void draw() {
  fill(left);
  rect(0, 0, width/2, height); 
  fill(right);
  rect(width/2, 0, width/2, height);
  fill(circle);
  ellipse(width/4, height/2, 60, 60);
  ellipse(3*width/4, height/2, 60, 60);
}

void keyPressed() {
  if (key == ' ') {
    left = color(random(0, 255), random(0, 255), random(0, 255));
    right = color(random(0, 255), random(0, 255), random(0, 255));
  }
}

void mousePressed(){
  circle = color(random(0, 255), random(0, 255), random(0, 255));
}
