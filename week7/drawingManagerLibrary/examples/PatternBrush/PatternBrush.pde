import drawing.library.*;
import processing.pdf.*;

DrawingManager drawingManager;

void setup() {
  size(1056,816,P3D);
  background(255);

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
    variableEllipse(mouseX, mouseY, pmouseX, pmouseY);
}

void variableEllipse(int x, int y, int px, int py) {
  float speed = abs(x-px) + abs(y-py);
  drawingManager.ellipse(x,y,speed,speed); 
}