import drawing.library.*;
import processing.pdf.*;

DrawingManager drawingManager;

void setup() {
  size(1056,816,P3D);
  background(255);
  smooth();
  drawingManager = new DrawingManager(this);
  
 }

void draw() {
}

void keyPressed() {
  if(key == ' '){
    drawingManager.savePDF();
  }
   if(key == 'c'){
    drawingManager.clear();
  }
}


void mouseDragged(){
   drawingManager.stroke(0,0,0);
   int xDist = mouseX-pmouseX;
   int yDist = mouseY-pmouseY;
   float theta = atan2(xDist,yDist);
   drawingManager.fill(0,0,0);
   drawingManager.pushMatrix();
   drawingManager.translate(mouseX,mouseY);
   drawingManager.rotate(TWO_PI-theta);
   drawingManager.triangle(-10,0, 10, 0, 0,random(10,100));
   drawingManager.popMatrix();
  

}