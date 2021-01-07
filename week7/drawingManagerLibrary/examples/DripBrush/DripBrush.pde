import drawing.library.*;
import processing.pdf.*;

DrawingManager drawingManager;
DShape shape;

float distInterval = random(10,100);
//variable to keep track of the distance 
//progressed while drawing. This will
//enable us to know when to start the next drip
float totalDist = 0;
//rate at which drips will progress down the canvas
float dripRate = 1;
ArrayList<DShape> drips = new ArrayList<DShape>();

void setup() {
  size(1056,816,P3D);
  background(255);
  smooth();
  drawingManager = new DrawingManager(this);
  drawingManager.strokeWeight(5);
 }

void draw() {
  //iterate backwards through the drip array list so we
  //don't encounter any issues when removing drips.
  for(int i=drips.size()-1;i>=0;i--){
    DShape drip = drips.get(i);
    
    //increase the delta of the drip on the y axis by
    // the interval specified in the dripRate variable
    drip.addDelta(0,dripRate);
    
    //stop the drip by removing it from the array list 
    // when it is of the bottom of the canvas.
    if(drip.position.y>=height){
     drips.remove(i); 
    }
  }
}

void keyPressed() {
  if(key == ' '){
    drawingManager.savePDF();
  }
   if(key == 'c'){
    drawingManager.clear();
  }
  //stop drips when s is pressed
  if(key == 's'){
     drips.clear(); 
  }
}

void mousePressed(){
  totalDist = 0;
   shape = drawingManager.addShape(); 
 
}
  
void mouseDragged(){
   drawingManager.stroke(0,0,0);
   shape.addVertex(mouseX,mouseY);
   PVector v = new PVector(mouseX-pmouseX,mouseY-pmouseY);
   totalDist += v.mag();
   //condition to check if total distance is 
   // greater than the distance interval
   if(totalDist>=distInterval){
     //reset the total dist
     totalDist = 0;
     //calculate a new random distance interval
     distInterval = random(10,100);
    //create a new dshape object for the new drip
    // add a vertex at the current mouse position 
    //add it to the drip array list.
     DShape drip = drawingManager.addShape();
     drip.addVertex(mouseX,mouseY);
     drips.add(drip);
   }
}