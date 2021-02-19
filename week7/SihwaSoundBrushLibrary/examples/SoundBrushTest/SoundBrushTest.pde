/*******************************
*  Sound Brush Test with Mic Input
*  This example demonstrates how you can use
*  SoundBrushManger with full functionalities.
*
*  Author: Sihwa Park
*  Email: sihwapark@ucsb.edu
*  11/12/2019
*******************************/
import ddf.minim.*;
import ddf.minim.analysis.*;
import controlP5.*;
import soundBrush.*;

Minim minim;
FFT fft;
AudioInput in;

int avgMode;

SoundBrushManager soundBrushManager;
int resolution; 
float z = 0;

ControlP5 cp5;
Slider minHueSlider, maxHueSlider;

boolean liveUpdate = false;
boolean syncAll = false;
boolean showWireFrame = false;
boolean randomHue = false;
boolean randomStroke = false;
boolean generativeMode = false;

float minHue, maxHue;
float minStrokeWidth, maxStrokeWidth;
float brushPatternStartAngle;

//Parameters for generative mode
boolean perlinNoise = false;
float minXDelta = -20;
float maxXDelta = 20;
float minYDelta = -20;
float maxYDelta = 20;
float maxVertexCount = 100;
float drawingInterval = 100;

int vertexCount = -1;
float lastTime;
PVector position = new PVector();
float xOff = 0.0;
float yOff = 0.0;

boolean randomAngle = false;
float angleOff = 0;

void setup() {
  //fullScreen(P3D);
  size(900, 900, P3D);
  
  minim = new Minim(this);
  in = minim.getLineIn();
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.window(FFT.HAMMING);
  
  resolution = 50;
  avgMode = SoundBrushManager.LOGARITHM;
  
  float spectrumScaleFactor = 2.0f;
  
  soundBrushManager = new SoundBrushManager(this, in.mix, fft, avgMode, resolution, spectrumScaleFactor);
  minHue = 0;
  maxHue = 200;
  minStrokeWidth = 10;
  maxStrokeWidth = 50;
  brushPatternStartAngle = 0;
  
  cp5 = new ControlP5(this);
  
  colorMode(HSB, 255);
  
  Group group = cp5.addGroup("Parameter Control")
                .setPosition(10,20)
                .setBackgroundHeight(100)
                .setSize(250, 370)
                .setBackgroundColor(color(255,50));
  
  minHueSlider = cp5.addSlider("minHue")
      .setGroup(group)
      .setLabel("Min Hue")
      .setPosition(10, 10)
      .setSize(100, 20)
      .setValue(0)
      .setColorBackground(color(0, 255, 100))
      .setColorForeground(color(0, 255, 240))
      .setColorActive(color(0, 255, 255))
      .setRange(0, 255);
  
  maxHueSlider = cp5.addSlider("maxHue")
      .setGroup(group)
      .setLabel("Max Hue")
      .setPosition(10, 50)
      .setSize(100, 20)
      .setValue(200)
      .setColorBackground(color(200, 255, 100))
      .setColorForeground(color(200, 255, 240))
      .setColorActive(color(200, 255, 255))
      .setRange(0, 255);
  
  cp5.addToggle("randomHueRange")
    .setGroup(group)
    .setLabel("Random Hue")
    .setPosition(195, 10)
    .setSize(45,20)
    .setValue(false);
    
  cp5.addSlider("startAngle")
      .setGroup(group)
      .setLabel("Pattren Rotation")
      .setPosition(10, 80)
      .setSize(100, 20)
      .setValue(0)
      .setRange(0, 360);
  
  cp5.addToggle("randomAngle")
    .setGroup(group)
    .setLabel("Random Ang.")
    .setPosition(195, 80)
    .setSize(45,20)
    .setValue(false);
    
  cp5.addSlider("spectrumScaleFactor")
    .setGroup(group)
    .setLabel("Spectrum Scale")
    .setPosition(10, 110)
    .setSize(100, 20)
    .setValue(2)
    .setRange(0, 100);
    
  cp5.addSlider("minStrokeWidth")
    .setGroup(group)
    .setLabel("Min StrokeWidth")
    .setPosition(10, 140)
    .setSize(100, 20)
    .setValue(10)
    .setRange(0, 255);
  
  cp5.addSlider("maxStrokeWidth")
    .setGroup(group)
    .setLabel("Max StrokeWidth")
    .setPosition(10, 170)
    .setSize(100, 20)
    .setValue(50)
    .setRange(0, 255);
  
  cp5.addToggle("randomStrokeWidth")
    .setGroup(group)
    .setLabel("   Random\n   Stroke")
    .setPosition(195, 140)
    .setSize(45,20)
    .setValue(false);
  
  cp5.addToggle("showWireFrame")
    .setGroup(group)
    .setLabel("Wire frame")
    .setPosition(10, 200)
    .setSize(45,20)
    .setValue(false);
    
  cp5.addToggle("liveUpdate")
    .setGroup(group)
    .setLabel("Live Update")
    .setPosition(65, 200)
    .setSize(45,20)
    .setValue(false);
    
  cp5.addToggle("syncAll")
    .setGroup(group)
    .setLabel("Sync")
    .setPosition(120, 200)
    .setSize(45,20)
    .setValue(false)
    .setVisible(false);
  
  cp5.addToggle("generativeDrawing")
    .setGroup(group)
    .setLabel("Generative")
    .setPosition(10, 240)
    .setSize(45,20)
    .setValue(false);
  
  cp5.addToggle("perlinNoise")
    .setGroup(group)
    .setLabel("Perlin Noise")
    .setPosition(65, 240)
    .setSize(45,20)
    .setVisible(false)
    .setValue(false);
  
  cp5.addSlider("drawingInterval")
    .setGroup(group)
    .setLabel("Drawing Interval")
    .setPosition(10, 280)
    .setSize(100, 20)
    .setValue(100)
    .setRange(0, 100);
  
  cp5.addSlider("maxVertexCount")
    .setGroup(group)
    .setLabel("Max Vertices")
    .setPosition(10, 310)
    .setSize(100, 20)
    .setValue(100)
    .setRange(0, 500);
    
  cp5.addButton("clearAll")
    .setGroup(group)
    .setLabel("Clear")
    .setPosition(10, 340)
    .setSize(110,20);
  
  cp5.addButton("saveImage")
    .setGroup(group)
    .setLabel("Save")
    .setPosition(130, 340)
    .setSize(110,20);
}

void draw() {
  background(0);
  
  if(generativeMode) {
    generate();
  }
  
  soundBrushManager.update();
  soundBrushManager.draw();
}

void generate() {
  float current = millis();
  
  if(vertexCount == -1) {
    if(randomHue) randomHueRange(true);
    if(randomStroke) randomStrokeWidth(true);
    if(randomAngle) randomAngle(true);
    
    if(perlinNoise) {
      xOff = random(1) * width;
      yOff = random(1) * height;
      
      position.x = noise(xOff) * width; //width / 2 + random(-1, 1) * width / 3;
      position.y = noise(yOff) * height; //height /2 + random(-1, 1) * height /3;
    } else {
      position.x = random(1) * width;
      position.y = random(1) * height;
    }
    
    soundBrushManager.addStroke(minHue, maxHue, minStrokeWidth, maxStrokeWidth);
    soundBrushManager.addVertexToCurrentStroke(position.x, position.y, z);
    vertexCount = 0;
    lastTime = current;
  } else {
    if(current - lastTime > drawingInterval) {
      if(randomAngle) randomAngle(true);
      
      if(perlinNoise) {
        position.x = noise(xOff) * width;
        position.y = noise(yOff) * height;
        
        xOff += 0.01;
        yOff += 0.01;
      } else {
        position.x += random(1) * (maxXDelta - minXDelta) + minXDelta;
        position.y += random(1) * (maxYDelta - minYDelta) + minYDelta;

        if(position.x > width) position.x = width;
        else if(position.x < 0) position.x = 0;
        
        if(position.y > height) position.y = height;
        else if(position.y < 0) position.y = 0;
      }
      
      soundBrushManager.addVertexToCurrentStroke(position.x, position.y, z);
      vertexCount++;
        
      if(vertexCount > maxVertexCount) vertexCount = -1;
      lastTime = current;
    }
  }
  
  
}

void mousePressed() {
  if(cp5.isMouseOver()) return;
  
  if(randomHue) randomHueRange(true);
  if(randomStroke) randomStrokeWidth(true);
  if(randomAngle) randomAngle(true);
  
  soundBrushManager.addStroke(minHue, maxHue, minStrokeWidth, maxStrokeWidth);
  soundBrushManager.addVertexToCurrentStroke(mouseX, mouseY, z);
}

void mouseDragged() {
  if(cp5.isMouseOver()) return;
  
  PVector inc = new PVector(mouseX - pmouseX, mouseY - pmouseY);
  float dist = inc.mag();
  
  //if(dist > 10) {
  //  PVector last = new PVector(pmouseX, pmouseY);
  //  PVector current = new PVector(mouseX, mouseY);
  //  float unit = 2.0f;
  //  int steps = floor(dist / unit);
  //  println(dist, steps);
  //  for(int i = 1; i <= steps; i++) {
  //    PVector p = PVector.lerp(last, current, (float)i / steps);
  //    soundBrushManager.addVertexToCurrentStroke(p.x, p.y, z);
  //  }
  //}
  
  soundBrushManager.addVertexToCurrentStroke(mouseX, mouseY, z); 
}

void minHue(float c) {
  if(minHueSlider == null) return;
  minHueSlider.setColorBackground(color(c, 255, 100))
              .setColorForeground(color(c, 255, 240))
              .setColorActive(color(c, 255, 255));
  minHue = c;       
}

void maxHue(float c) {
  if(maxHueSlider == null) return;
  maxHueSlider.setColorBackground(color(c, 255, 100))
              .setColorForeground(color(c, 255, 240))
              .setColorActive(color(c, 255, 255));
  maxHue = c;
}

void startAngle(float a) {
  soundBrushManager.setPatternStartAngle(radians(a));
}

void spectrumScaleFactor(float s) {
  soundBrushManager.setSpectrumScaleFactor(s);
}

void minStrokeWidth(float w) {
  minStrokeWidth = w; 
}

void maxStrokeWidth(float w) {
  maxStrokeWidth = w;
}

void liveUpdate(boolean live) {
  if(cp5.getController("syncAll") == null) return;
  
  liveUpdate = live;
  cp5.getController("syncAll").setVisible(live);
  soundBrushManager.setLiveUpdate(live);
}

void syncAll(boolean sync) {
  syncAll = sync;
  soundBrushManager.setSyncAll(syncAll);
}

void showWireFrame(boolean show) {
  showWireFrame = show;
  soundBrushManager.setShowWireFrame(showWireFrame);
}

void clearAll() {
  soundBrushManager.clearAllStrokes();
  if(generativeMode) vertexCount = -1;
}

void randomHueRange(boolean random) {
  randomHue = random;
  if(randomHue == false) return;
  
  minHue = random(1) * 255; 
  minHueSlider.setColorBackground(color(minHue, 255, 100))
              .setColorForeground(color(minHue, 255, 240))
              .setColorActive(color(minHue, 255, 255))
              .setValue(minHue);
              
  maxHue = random(1) * 255; 
  maxHueSlider.setColorBackground(color(maxHue, 255, 100))
              .setColorForeground(color(maxHue, 255, 240))
              .setColorActive(color(maxHue, 255, 255))
              .setValue(maxHue);
}

void randomStrokeWidth(boolean random) {
  randomStroke = random;
  if(randomStroke == false) return;
  
  minStrokeWidth = random(1) * 100;
  cp5.getController("minStrokeWidth").setValue(minStrokeWidth);
  
  maxStrokeWidth = random(1) * (255 - minStrokeWidth) + minStrokeWidth;
  cp5.getController("maxStrokeWidth").setValue(maxStrokeWidth);
  
  float spectrumScaleFactor = maxStrokeWidth * 0.05;
  
  cp5.getController("spectrumScaleFactor").setValue(spectrumScaleFactor);
  soundBrushManager.setSpectrumScaleFactor(spectrumScaleFactor);
}

void randomAngle(boolean random) {
   if(cp5.getController("startAngle") == null) return;
   
   if(random) {
     if(perlinNoise) angleOff = (randomAngle)? angleOff + 0.01 : random(1) * 360;

     brushPatternStartAngle = (perlinNoise)? noise(angleOff) * 360 : random(1) * 360;
     soundBrushManager.setPatternStartAngle(radians(brushPatternStartAngle));
     
     cp5.getController("startAngle").setValue(brushPatternStartAngle);
   }
   
   randomAngle = random;
}

void generativeDrawing(boolean generative) {
  if(cp5.getController("perlinNoise") == null) return;
  
  generativeMode = generative;
  if(generativeMode) vertexCount = -1;
  
  cp5.getController("perlinNoise").setVisible(generative);
}

void perlinNoise(boolean perlin) {
  perlinNoise = perlin;
  vertexCount = -1;
}

void drawingInterval(float v) {
  drawingInterval = v;
}

void maxVertexCount(float v) {
  maxVertexCount = v;
}

void saveImage() {
  save("screenshot_" + year() + month() + day() + hour() + minute() + second() +".png");
}

void keyPressed() {
  if(key == 'l') {
    liveUpdate = !liveUpdate;
    soundBrushManager.setLiveUpdate(liveUpdate);
    Toggle t = (Toggle)cp5.getController("liveUpdate");
    t.toggle();
  }
  else if(key == 's') {
    syncAll = !syncAll;
    soundBrushManager.setSyncAll(syncAll);
    Toggle t = (Toggle)cp5.getController("syncAll");
    t.toggle();
  }
  else if(key == 'c') {
    clearAll();
  }
  else if(key == ' ') {
    saveImage();
  }
  else if(key == 'w') {
    showWireFrame = !showWireFrame;
    soundBrushManager.setShowWireFrame(showWireFrame);
    Toggle t = (Toggle)cp5.getController("showWireFrame");
    t.toggle();
  }
}
