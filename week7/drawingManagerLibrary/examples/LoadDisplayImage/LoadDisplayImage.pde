import drawing.library.*;
import processing.pdf.*;

DrawingManager drawingManager;
PImage img;  // Declare variable "a" of type PImage

void setup() {
  size(1056,816,P3D);
  background(255);
  frameRate(20);
  smooth();
  drawingManager = new DrawingManager(this);
    img = loadImage("moonwalk.jpg");  // Load the image into the program  

 }

void draw() {
  if(mousePressed){
    //push into the transformation matrix
    drawingManager.pushMatrix();
    //translate to mouseX, mouseY;
    drawingManager.translate(mouseX,mouseY);
    //calculate angle of mouse vector using a PVector heading function
    PVector p = new PVector(mouseX-pmouseX,mouseY-pmouseY);
    float theta = p.heading();
    //rotate by this angle
    drawingManager.rotate(theta);
    //scale down to 
    drawingManager.scale(0.5,0.5);
    //Draw the image. Setting the x and y values of the image call to
    //-img.width/2 and -img.height/2 will place the center of the image
    // where the mouse cursor is.
    drawingManager.image(img,-img.width/2,-img.height/2,img.width,img.height);
    //pop out of the transformation matrix.
    drawingManager.popMatrix();
  }
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
 
}
  