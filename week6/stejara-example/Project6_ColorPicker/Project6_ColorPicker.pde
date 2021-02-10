/* Project 6: Color Picker by Stejara Dinulescu
 * This project is a UI that allows the user create a color palette.
 * The user can pick the number of palette tiles they would like to see on screen with a slider.
 * The user can also pick from a number of options to generate color palettes:
     * "Random" assigns random colors to the tiles.
     * "Red", "Blue", and "Green" options allow for tile colors to be generated on that specific color scheme.
     * "Selected" allows the user to pick a tile that they like for the UI to generate a color palette based on the selected tile's color.
 */

import controlP5.*;
ControlP5 cp5;
Controller numPalettes;
DropdownList colSwatch;

int paletteNum = 64;
int colSwatchType = 0;

float r, g, b, a;
color col;
int strokeNum = 5;

int counter = 1;
boolean selected = false;

Palette paletteList[] = new Palette[paletteNum];

void setup() {
  size(805, 805);
  background(255);
  
  initCP5();
  initPalette(); 
}

void draw() {
  background(255);
  if (colSwatchType == 4 && selected == true) { handleSelected(); }
  for (int i = 0; i < paletteNum; i++) { paletteList[i].displayPalette(); }
}

void mousePressed() {
  if (colSwatchType == 4) {
    counter++;
    if (counter % 2 == 0) { selected = true; } else { selected = false; }
  }
  for (int i = 0; i < paletteNum; i++) { paletteList[i].isPressed(selected); }
}

void initCP5() {
  cp5 = new ControlP5(this);

  numPalettes = cp5.addSlider("paletteNum")
    .setPosition(625, 24)
    .setRange(1, 64);

  colSwatch = cp5.addDropdownList("colSwatchType") 
    .setPosition(625, 50)
    .addItem("random", 0)
    .addItem("red", 1)
    .addItem("green", 2)
    .addItem("blue", 3)
    .addItem("selected", 4);
}

void initPalette() {
  int size = 100;
  int c = -1;
  for (int i = strokeNum; i < width - strokeNum; i += size) {
    for (int j = strokeNum; j < height - strokeNum; j += size) {
      c++;
      r = random(255);
      g = random(255);
      b = random(255);
      a = random(50, 255);
      Palette p = new Palette(color(r, g, b, a), size, i, j);         
      paletteList[c] = p;
    }
  }
}

void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isFrom("colSwatchType") && colSwatchType != 4) {
    for (int i = 0; i < paletteNum; i++) {
      handleColorPalette(i);
    }
  }
}

void handleColorPalette(int i) {
  switch(colSwatchType) {
  case 0:
    r = random(255);
    g = random(255);
    b = random(255);
    break;
  case 1: 
    r = random(100, 255);
    g = random(50, 150);
    b = random(50, 100);
    break;
  case 2: 
    r = random(50, 150);
    g = random(100, 255);
    b = random(50, 150);
    break;
  case 3: 
    r = random(50, 150);
    g = random(50, 150);
    b = random(100, 255);
    break;
  }
  a = random(50, 255);
  col = color(r, g, b, a);
  paletteList[i].c = col;
}

void handleSelected() {
  //println("selected!");
  for (int i = 0; i < paletteNum; i++) {
    if (paletteList[i].pressed) {
      col = paletteList[i].c;
      //println(red(col) + " " + blue(col) + " " + green(col));
      for (int j = 0; j < paletteNum; j++) {
        r = random((red(col) - 50), (red(col) + 50));
        g = random((green(col) - 50), (green(col) + 50));
        b = random((blue(col) - 50), (blue(col) + 50));
        a = random(50, 255);
        //println(r, g, b, a);
        paletteList[j].c = color(r, g, b, a);
      }
    }
  }
  selected = false;
  counter++;
}
