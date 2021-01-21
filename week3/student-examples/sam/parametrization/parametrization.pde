import controlP5.*;
ControlP5 cp5;

Pyramid py;
Wave wa;
Intestinal in;

float val1 = 70;
float val2 = 18;
float val3 = 2.5;
float val4 = 0.1;
float val5 = 255;


Controller sli1;
Controller sli2;
Controller sli3;
Controller sli4;
Controller sli5;


Controller xP;
Controller xN;
Controller yP;
Controller yN;

ControlWindow controlWindow;

Controller toggle;
boolean toggleValue = true;
Controller toggle2;
boolean animate = false;
Controller toggle3;
boolean contrast = false;

float backgroundColor = 0;
float shapeColor = 255;

float uXp;

void setup() {
  //size(1024, 768, P3D);
  fullScreen(P3D);
  cp5 = new ControlP5(this);
  py = new Pyramid();
  wa = new Wave();
  in = new Intestinal();
  
  fill(100);
  
 
  // create a toggle
  cp5.addToggle("toggleValue")
    .setPosition(25, 150)
    .setSize(50, 20)
    //.setColorValue(color(255, 255, 255))
    //.setWindow(controlWindow)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
    ;

  // create a toggle
  cp5.addToggle("animate")
    .setPosition(25, 200)
    .setSize(50, 20)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
    ;


  // create a toggle
  cp5.addToggle("contrast")
    .setPosition(25, 250)
    .setSize(50, 20)
    .setColorActive(color(150))
    .setColorForeground(color(100))
    .setColorBackground(color(50))
    .setColorLabel(150);
    ;

  sli1 =  cp5.addSlider("val1")
    .setPosition(25, 25)
    .setRange(50, 400)
    .setColorActive(color(255, 150))
    .setColorForeground(color(255, 100))
    .setColorBackground(color( 50))
    .setColorLabel(150);
    ;

  sli2 =  cp5.addSlider("val2")
    .setPosition(25, 50)
    .setRange(15, 30)
    .setColorActive(color(255, 150))
    .setColorForeground(color(255, 100))
    .setColorBackground(color(50))
    .setColorLabel(150);
    ;

  sli3 =  cp5.addSlider("val3")
    .setPosition(25, 75)
    .setRange(0, 3)
    .setColorActive(color(255, 150))
    .setColorForeground(color(255, 100))
    .setColorBackground(color(50))
    .setColorLabel(150);
    ;

  sli4 =  cp5.addSlider("val4")
    .setPosition(25, 100)
    .setRange(0.1, 2)
    .setColorActive(color(255, 150))
    .setColorForeground(color(255, 100))
    .setColorBackground(color(50))
    .setColorLabel(150);
    ;

  sli4 =  cp5.addSlider("val5")
    .setPosition(25, 125)
    .setRange(1, 255)
    .setColorActive(color(255, 150))
    .setColorForeground(color(255, 100))
    .setColorBackground(color(50))
    .setColorLabel(150);
    ;

  /* sli1 =  cp5.addSlider("val1")
   .setPosition(25, 25)
   .setRange(-30, 30)
   ;
   
   sli2 =  cp5.addSlider("val2")
   .setPosition(25, 50)
   .setRange(-10, 20)
   ;
   
   sli3 =  cp5.addSlider("val3")
   .setPosition(25, 75)
   .setRange(-10, 20)
   ;*/


  /*sli4 =  cp5.addSlider("val4")
   .setPosition(25, 100)
   .setRange(-3 , 3)
   ;*/


  /* xP = cp5.addButton("uXp")
   .setPosition(25,50);*/
  background(0);
}



void draw() {
  if (contrast) {
    backgroundColor = 255;
    shapeColor = 0;
  } else {
    backgroundColor = 0;
    shapeColor = 255;
  }


  if (toggleValue) {
    background(backgroundColor);
  }
  //lights();

  pushMatrix();
  translate(width/2, height/3);
  rotateX(-PI/2);
  rotateZ(millis()/5000f);
  //rotateX(millis()/5000f);
  in.display();
  //py.display();
  //wa.display();


  popMatrix();

  if (animate) {
    val2+= 0.01;
  }
}
