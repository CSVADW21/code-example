import java.awt.*;
import java.awt.event.*;
import java.awt.datatransfer.*;
import javax.swing.*;
import java.io.*;

PImage img;  // Declare a variable of type PImage
Swatch swatch1;
Swatch swatch2;
Swatch swatch3;

ArrayList<Swatch> swatches; 
boolean sizeShift = false;
boolean delete = false;
boolean toggleLines = true;
Clipboard clipboard;

void setup() {
  size(1230,920);
  
  swatches = new ArrayList<Swatch>();
  swatch1 = new Swatch(100,100,80,80);
  swatch2 = new Swatch(500,100,80,80);
  swatch3 = new Swatch(400,200,80,80);
  swatches.add(swatch1);
  swatches.add(swatch2);
  swatches.add(swatch3);  
  
  // Make a new instance of a PImage by loading an image file
  img = loadImage("dinnerware_set.jpeg");
  img.loadPixels();
  
  clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
  
  for (int i = 0; i < swatches.size(); i++) {
    updateColor(swatches.get(i));
  }  
}

void draw() {
  background(0);
  image(img,0,0);
  // render swatches
  for(int i=0;i<swatches.size();i++){
    color fillColor = swatches.get(i).fillColor;
    
    // render connecting lines
    if(toggleLines) {
      stroke(fillColor);
      line(100*i+50, 40,
        swatches.get(i).position.x, swatches.get(i).position.y
      );
    }
    
    // render swatch in location
    swatches.get(i).draw();
    
    // render swatch in top palette
    rectMode(CORNER);
    fill(fillColor);
    rect(i*100, 0, 100, 80);
    
    // render hex label
    fill(0);
    if(brightness(fillColor) < 128) { fill(240); }
    rect(i*100, 80, 100, 20);
    fill(fillColor);
    textSize(12);
    text("#" +
      hex(fillColor, 6),
      10+i*100,
      95); 
  }
}
void keyPressed(){
  if(key == 'c') {
    for(int i= swatches.size()-1;i>=0;i--){ swatches.remove(i); }
  }
  if(key == 'x') {
    delete = true;
  } else {
    sizeShift = true;
  }
  if(key == 'l') {
    toggleLines = !toggleLines;
  }
}

void keyReleased(){
  sizeShift = false;
  delete = false;
}

void mousePressed(){
  boolean anyHit = false;
  for(int i= swatches.size()-1;i>=0;i--){
   Swatch s = swatches.get(i);
   boolean hitTest = s.hitTest(mouseX,mouseY);
   
   if(hitTest == true){
     if(delete == true) {
       swatches.remove(s);
       return;
     } else {
        anyHit = true;
        s.selected = true; 
        return;
     }
   }
  }
  if(anyHit == false) {
      Swatch newSwatch = new Swatch(mouseX,mouseY,50,50);
      updateColor(newSwatch);
      swatches.add(newSwatch);
  }
}

void mouseDragged(){
   PVector delta = new PVector(mouseX-pmouseX,mouseY-pmouseY);
   for(int i=0;i<swatches.size();i++){
     Swatch s = swatches.get(i);
     if(s.selected == true){
       if(sizeShift == false){
          s.moveBy(delta);
          updateColor(s);
       }
       else{
         s.updateSize(delta,0);
         updateColor(s);
       }
       return;
     }  
   }   
}

void mouseReleased(){
  deselectAllSwatches();
}

void deselectAllSwatches(){
   for(int i=0;i<swatches.size();i++){
      swatches.get(i).selected = false;
   }
}

color getAverage(PImage selection) {
  //image(selection,0,0);
  selection.loadPixels();
  int r = 0, g = 0, b = 0;
  for (int i=0; i<selection.pixels.length; i++) {
    color c = selection.pixels[i];
    r += c>>16&0xFF;
    g += c>>8&0xFF;
    b += c&0xFF;
  }
  r /= selection.pixels.length;
  g /= selection.pixels.length;
  b /= selection.pixels.length;
  return color(r, g, b);
}

void updateColor(Swatch swatch) { 
  color averageColor = getAverage(
    img.get(
      int(swatch.position.x - swatch.swatchWidth/2),
      int(swatch.position.y - swatch.swatchHeight/2),
      swatch.swatchWidth,
      swatch.swatchHeight
    )
  );
  swatch.setColor(averageColor);
  StringSelection data = new StringSelection("#" + hex(averageColor, 6));
  clipboard.setContents(data, data);
}
