/**
 * Continuous Lines. 
 * 
 * Click and drag the mouse to draw a line. 
 */

void setup() {
   size(1056,816);
  background(255);
}

void draw() {
  stroke(0);
  if (mousePressed == true) {
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}
