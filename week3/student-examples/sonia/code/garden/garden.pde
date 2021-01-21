// Inspired by Jennifer Jacobs, Peter M Maurer and Alexander Calder

import controlP5.*;
ControlP5 cp5;

// --------------------------------------------------------------------------------------

// Point 3D by Jennifer Jacobs for CSVAD
class Point3D {
  float x;
  float y;
  float z;

  Point3D(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
}

// --------------------------------------------------------------------------------------

int idx = 0;
PShape [] shapes;

int levels = 5;
int sphere_size = 3;
float n = 4;
float d = 10;
float R = 30;
float roses_weight = 0.5;
float mobile_weight =  1;

boolean toggleValue = false;
Controller levelsSlider;
Controller sphere_sizeSlider;
Controller nSlider;
Controller dSlider;
Controller RSlider;
Controller rosesSlider;
Controller mobileSlider;
CallbackListener cb;

// --------------------------------------------------------------------------------------

void setup() {
  size(1024, 1024, P3D);
  cp5 = new ControlP5(this);

  levelsSlider = cp5.addSlider("levels")
    .setPosition(25, 25)
    .setRange(1, 5)
    ;

  sphere_sizeSlider = cp5.addSlider("sphere_size")
    .setPosition(25, 25*2)
    .setRange(2, 5)
    ;

  nSlider = cp5.addSlider("n")
    .setPosition(25, 25*3)
    .setRange(1, 10)
    ;

   dSlider = cp5.addSlider("d")
    .setPosition(25, 25*4)
    .setRange(10, 100)
    ;

  RSlider = cp5.addSlider("R")
    .setPosition(25, 25*5)
    .setRange(25, 75)
    ;

  rosesSlider = cp5.addSlider("roses_weight")
    .setPosition(25, 25*6)
    .setRange(.125, .75)
    ;

   mobileSlider = cp5.addSlider("mobile_weight")
    .setPosition(25, 25*7)
    .setRange(.5, 2.5)
    ;

  cp5.addToggle("toggleValue")
     .setPosition(25,25*8)
     .setSize(50,20)
     ;

  cp5.addToggle("ortho")
     .setPosition(25,25*8)
     .setSize(50,20)
     .setValue(true)
     .setMode(ControlP5.SWITCH)
     .setColorCaptionLabel(0)
     ;

  cp5.getController("levels").getCaptionLabel().setColor(0);
  cp5.getController("sphere_size").getCaptionLabel().setColor(0);
  cp5.getController("n").getCaptionLabel().setColor(0);
  cp5.getController("d").getCaptionLabel().setColor(0);
  cp5.getController("R").getCaptionLabel().setColor(0);
  cp5.getController("roses_weight").getCaptionLabel().setColor(0);
  cp5.getController("mobile_weight").getCaptionLabel().setColor(0);

  cb = new CallbackListener() {
    public void controlEvent(CallbackEvent theEvent) {
      switch(theEvent.getAction()) {
        case(ControlP5.ACTION_ENTER):
          break;
        case(ControlP5.ACTION_RELEASED):
          createRoses(); break;
        case(ControlP5.ACTION_RELEASEDOUTSIDE):
          createRoses(); break;
         default:
          break;
      }
    }
  };

  // add the above callback to relevant controls (affect roses)
  nSlider.addCallback(cb);
  dSlider.addCallback(cb);
  RSlider.addCallback(cb);
  rosesSlider.addCallback(cb);

  createRoses();
}

// --------------------------------------------------------------------------------------

void draw() {
  background(253);
  idx = 0;
  lights();
  pushMatrix();
  if (toggleValue == false) {
    ortho();
  }
  translate(width/2, height/2);

  beginCamera();
  // ortho();
  camera(0, 0, 1000, 0, 0, 0, 0, 1, 0);
  endCamera();

  fill(218,165,32);
  strokeWeight(mobile_weight);
  stroke(218,165,32);
  specular(204, 102, 0);
  // sphere(200);

  mobile(levels, 0, -width/6);
  popMatrix();
}

// Creates mobile
void mobile(int level, float x, float y) {
  if (level == 0) return;
  pushMatrix();
  translate(x, y, 0);
  sphere(sphere_size);
  line(0, -width/18, 0, 0, 0, 0);
  pushMatrix();
  translate(0, -width/18, 0);
  sphere(sphere_size);
  popMatrix();

  // With some probability add horizontal line and children
  pushMatrix(); // Add Z Rotation
  float rz = (sin(.005*frameCount))/2;
  float az = max((float) Math.random()*10, 10.0);
  rotateZ((float)(rz*az*Math.PI/180));

  pushMatrix(); // Add Y Rotation
  rotateY((float)(0.1*frameCount * Math.PI / 180));

  if (level == 1) {
    PShape s = shapes[idx];
    idx++;
    shape(s, 0, 0);
  } else {
    line(-height/6, 0, 0, height/6, 0, 0);
    // leftChild
    mobile(level-1, -height/6, width/18);
    // rightChild
    mobile(level-1, height/6, width/18);
  }

  popMatrix(); // End Y Rotation

  popMatrix(); // End Z Rotation
  popMatrix();
}
// --------------------------------------------------------------------------------------

// Draws a Maurer Rose
PShape drawRose(float n, float d, float R) {
  float z = 0;
  Point3D[] rose = new Point3D[360+1];
  for (int i = 0; i <= 360; i++) {
    float t = i*d*PI/180;
    float r = R*sin(n*t);
    float x = r*cos(t);
    float y = r*sin(t);
    rose[i] = new Point3D(x,y,z);
  }

  PShape rosey = createShape();
  // Draw a simple rose
  rosey.beginShape();
    for(int idx = 0; idx <= 360; idx++) {
      Point3D p = rose[idx];
      rosey.vertex(p.x, p.y, 0);
    }
    if (Math.random() <= .5) {
      for(int idx = 0; idx <= 360; idx++) {
        Point3D p = rose[idx];
        rosey.vertex(0, p.x, p.y);
      }
    }
  rosey.endShape();
  return rosey;
}

// Draw a set of roses
void createRoses() {
  noFill();
  int maxLevel = 5;
  int nLevels = (int)(Math.pow(2, maxLevel));
  strokeWeight(roses_weight);
  stroke(218,165,32);
  shapes = new PShape[nLevels];
  for(int i = 0; i < nLevels; i++) {
    shapes[i] = drawRose(1+(float)(Math.random()*n), 10+(float)(Math.random()*d), 15+(float)(Math.random()*R));
  }
}
