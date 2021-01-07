import drawing.library.*;
import processing.pdf.*;

DrawingManager drawingManager;
DShape shape;
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

void mousePressed(){
   shape = drawingManager.addShape(); 
 
}
  
void mouseDragged(){
   drawingManager.stroke(0,0,0);
   shape.addVertex(mouseX,mouseY); 
}