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
  if(key == 'v'){
    normalizeShape();
  }
}

void mousePressed(){
   shape = drawingManager.addShape(); 
 
}
  
void mouseDragged(){
   drawingManager.stroke(0,0,0);
   shape.addVertex(mouseX,mouseY); 
}

void normalizeShape(){
 ArrayList<DPoint> points = shape.getNormalizedVertices();
 DShape s2 = drawingManager.addShape();
 for(int i=0;i<points.size();i++){
   s2.addVertex(points.get(i).x,points.get(i).y);
 }
}