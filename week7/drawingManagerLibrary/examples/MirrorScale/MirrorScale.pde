/**
 * MirrorScale
 * 
 */


import drawing.library.*;
import processing.pdf.*;

//instance of DrawingManager library
DrawingManager drawingManager;

//total number of lines to be drawn
int linecount = 10;
//list of shapes
ArrayList<DShape> shapes = new ArrayList<DShape>();
void setup() {
  size(792,612,P3D);
  background(255);
  smooth();
  //initialize DrawingManager
  drawingManager = new DrawingManager(this);
 }

void draw() {
}

//save and clear functions
void keyPressed() {
  if(key == ' '){
    drawingManager.savePDF();
  }
  if(key == 'c'){
    drawingManager.clear();
  }
}



void mouseReleased(){
}

void mouseDragged(){
  //set the stroke to black
   drawingManager.stroke(0,0,0);
   float scale = 1;
   //loop through each shape and add a vertex
   for(int i = 0; i<linecount;i+=2){
     DShape shape1 = shapes.get(i);
     DShape shape2 = shapes.get(i+1);
     float x = mouseX-pmouseX;
     float y = mouseY-pmouseY;
       x = x*scale;
       y = y*scale;
       shape1.addDelta(x,y);
       shape2.addDelta(-x,y);
       scale-=0.15;
     
   }
 
 }
 
 
 void mousePressed(){
  //clear all existing shapes
  shapes.clear();
  //use a loop to create a new set of shapes
  
  for(int i = 0; i<linecount;i++){
     //initialize a new DShape object
    DShape s = drawingManager.addShape(); 
    shapes.add(s);
    s.translate(mouseX,mouseY);
  }

 }
   
 