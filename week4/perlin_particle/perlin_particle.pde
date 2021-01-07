//Perlin noise example. Modified from:

// M_1_5_03_TOOL.pde
// Agent.pde, GUI.pde
// 
// Generative Gestaltung, ISBN: 978-3-87439-759-9
// First Edition, Hermann Schmidt, Mainz, 2009
// Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
// Copyright 2009 Hartmut Bohnacker, Benedikt Gross, Julia Laub, Claudius Lazzeroni
//
// http://www.generative-gestaltung.de


import controlP5.*;


// ------ agents ------
Agent[] agents = new Agent[10000]; // create more ... to fit max slider agentsCount
int agentsCount = 4000;
float noiseScale = 100, noiseStrength = 10, noiseZRange = 0.4;
float overlayAlpha = 10, agentsAlpha = 90, strokeWidth = 0.3;

// ------ ControlP5 ------
ControlP5 controlP5;
boolean showGUI = false;
Slider[] sliders;

void setup(){
  size(1280,800);
  background(0);
  smooth();
  for(int i=0; i<agents.length; i++) agents[i] = new Agent();
  setupGUI();
}

void draw(){
  fill(0, overlayAlpha);
  noStroke();
  rect(0,0,width,height);

  stroke(255, agentsAlpha);
  //draw agents
 
   for(int i=0; i<agentsCount; i++){
     agents[i].update();
   }
  
 

  drawGUI();
}
