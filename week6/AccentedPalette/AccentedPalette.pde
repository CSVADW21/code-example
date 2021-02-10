//Accented Palette Example from Code as Creative Medium

color base; color accent; 

color[] baseColors = new color[8]; // 8 base colors (same rgb, different alpha values)
color[] accentColors = new color[3]; // 3 accent colors (same rgb, different alpha values)

int numRows = 20; int numCols = 20; // number of rows and columns for the generative grid

void setup() {
  // setup basic canvas properties
  size(500, 500); 
  background(255);
  noStroke();
  
  // pick random color for base, calculate the complement for the accent color
  base = color(random(0, 255), random(0, 255), random(0, 255)); 
  accent = color(255 - red(base), 255 - blue(base), 255 - green(base));
  
  drawPalette();
  
  //separate palette and generative grid piece
  fill(255);
  rect(0, height/10 + 0.5*height/10, width, height/20);
  
  drawGrid();
}

void drawPalette() {
  //draw base color
  fill(base); 
  rect(0, 0, 3 * width/4, height/10);
  // draw accent color
  fill(accent); 
  rect(3*width/4, 0, width/4, height/10);
  //draw the color palette for base and accent color
  for (int i = 0; i < baseColors.length; i++) {
    color c = color(base, 20 + i * (235/baseColors.length));
    baseColors[i] = c;
    fill(c);
    rect(i * (3*width/4)/baseColors.length, height/10, (3*width/4)/baseColors.length + 1, height/10);
  }
  for (int i = 0; i < accentColors.length; i++) {
    color c = color(accent, 20 + i * (235/accentColors.length));
    accentColors[i] = c;
    fill(c);
    rect((3*width/4) + i * (width/4)/accentColors.length, height/10, (width/4)/accentColors.length + 1, height/10);
  }
}

void drawGrid() {
  //partition rest of canvas into a grid
  for (int i = 0; i < numRows; i ++) {
    for (int j = 0; j < numCols; j++) {
      float baseOrAccent = random(0, 1); 
      if (baseOrAccent < 0.75) { // 75% chance of picking one of the base colors
        int alphaIndex = (int)random(0, baseColors.length);
        fill(baseColors[alphaIndex]);
      } else { // 25% chance of picking one of the accent colors
        int alphaIndex = (int)random(0, accentColors.length); 
        fill(accentColors[alphaIndex]);
      }
      rect(i * width/numRows, height/5 + j * height/numCols, width/numRows, height/numCols);
    }
  }
}
