//example for saving an image from the display window
//reference: https://processing.org/reference/save_.html

float rW = 40; 
float rH = 40; 
float strokeWeight = 3;

void setup() {
  size(400, 400);
  background(255);
  drawStuff(); // draw our things!
  save("filenameToSave.jpg"); //saves a JPEG file. 
  // can save any major file extension (.tif, .tga, .png, .jpg)
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
