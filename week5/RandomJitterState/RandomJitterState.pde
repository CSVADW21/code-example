import drawing.library.*;
import processing.pdf.*;

DrawingManager drawingManager;
DShape shape;
int count =0;
int limit = 700;
Boolean jitter = false;
void setup() {
  size(1056,816);
  background(255);  
  smooth();
  drawingManager = new DrawingManager(this);
 }

void draw() {
  count++;
  if(count>=limit){
    count = 0;
    jitter = !jitter;
    count = round(random(500,5000));
  }
  println(count);
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
   float x;
   float y;
   if(jitter){
      x = mouseX-pmouseX+random(-10,10);
      y = mouseY -pmouseY+random(-10,10); 
   }
   else{
     x = mouseX-pmouseX;
     y = mouseY -pmouseY; 
   }
   shape.addDelta(x, y);
}

void mousePressed(){
  shape = drawingManager.addShape();
  shape.translate(mouseX,mouseY);
}
