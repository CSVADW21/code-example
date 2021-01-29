import controlP5.*;

int seedCount = 100;
int dandelionCount = 10;
float velocityScaling = 1.0;
float rotationVariance = 60;

ArrayList<SeedSystem> seedSystems;

// ------ ControlP5 ------
ControlP5 controlP5;
boolean showGUI = false;
Slider[] sliders;



void setup(){
  size(1280,800);
   smooth();

 seedSystems = new ArrayList<SeedSystem>();
 PShape seedShape = loadShape("seed.svg");
 for(int i=0;i<dandelionCount;i++){
   float x = random(0,width);
   float y = random (200,height/2);
   float sd = random(10,60);
   int alpha = round(map(i,0,dandelionCount,1,255));
   SeedSystem seedSystem = new SeedSystem(seedShape, new PVector(x, y), seedCount, sd, alpha);
   seedSystems.add(seedSystem);
 }
 
 
   setupGUI();


 // noLoop();
}

void draw(){
  background(0);
   for (int i = seedSystems.size()-1; i >= 0; i--) {
     seedSystems.get(i).update();
   }
  
  drawGUI();

}
