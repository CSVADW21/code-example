class Palette {
  color c;
  float xPos;
  float yPos;
  float size;
  boolean pressed;
  int pressedNum = 1;
  int strokeNum = 5;
  
  Palette(color c, float size, float xPos, float yPos) {
    this.c = c;
    this.size = size;
    this.xPos = xPos;
    this.yPos = yPos;
  }
  
  void displayPalette() {
    fill(c);
    noStroke();
    //if (pressed && pressedNum % 2 == 1) { stroke(0); strokeWeight(strokeNum); } else { noStroke();}
    rect(xPos, yPos, size - strokeNum, size - strokeNum);
  }
  
  boolean isPressed(boolean selected) {
    if (selected) {
      if (mouseX > xPos && mouseX < xPos + size && mouseY > yPos && mouseY < yPos + size) 
      { pressed = true; } else { pressed = false; }
      
      pressedNum++;
    }
    return pressed;
  }
  
}
