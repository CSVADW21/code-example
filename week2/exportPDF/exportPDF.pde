//pdf export example for single frames (static images)
//reference: https://processing.org/reference/libraries/pdf/index.html

import processing.pdf.*; //import processing's pdf library

float rW = 40; 
float rH = 40; 
float strokeWeight = 3;

void setup() {
  size(400, 400);
  //size(400, 400, PDF, "filenameToSave.pdf"); // if you do this, the display window won't open up but your pdf will export. 
  // if you are satisfied with your sketch, you can do this at the very end. 
  // or, you can follow the rest of this example and use beginRecord and endRecord. that way, you will always get a pdf exported with every run time. 
  // if you want to keep documentation of your various iterations, use beginRecord and endRecord (with unique filenames, or using a timestamp!)

  background(255);
  beginRecord(PDF, "filenameToSave.pdf"); // start the pdf capture
  drawStuff(); // draw our things!
  endRecord(); // stop the capture, save the pdf file. The PDF will be in your Processing project folder.
}

void draw() {}

void drawStuff() { // some fun grid stuff!
  rectMode(CENTER);
  strokeWeight(strokeWeight);
  stroke(255);
  for (int j = 0; j < height/rH; j++) {
    for (int i = 0; i < width/rW; i++) {
      fill(0);
      rect(i*rW + rW/2, j*rH + rH/2, rW - 2*strokeWeight, rH - 2*strokeWeight);
      fill(random(50, 200));
      float wobble = random(-20, 20);
      rect(i*rW + rW/2 + wobble, j*rH + rH/2 - wobble, rW/2 - 2*strokeWeight, rH/2 - 2*strokeWeight);
    }
  }
}
