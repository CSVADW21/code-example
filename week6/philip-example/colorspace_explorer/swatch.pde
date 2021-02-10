class Swatch{
 int swatchWidth;
 int swatchHeight;
 PVector position;
 int hue;
 int sat;
 int bri;
 int order;
 boolean selected;
 color fillColor;
 
 Swatch(int x,int y, int w, int h){
  position = new PVector(x,y);
   swatchWidth = w;
   swatchHeight = h;
   hue = round(random(0,100));
   sat = round(random(0,100));
   bri = round(random(0,100));
   selected = false;
 }
 
  boolean hitTest(int x,int y){
    if(swatchWidth < 25) {
      if(x>= position.x-(swatchWidth) && x<=position.x+(swatchWidth)){
        
        if(y >= position.y-(swatchHeight) && y<=position.y+(swatchHeight)){
        return true;
        
        }
      }
    }
    if(x>= position.x-(swatchWidth/2) && x<=position.x+(swatchWidth/2)){
      
      if(y >= position.y-(swatchHeight/2) && y<=position.y+(swatchHeight/2)){
      return true;
      
      }
    }
    return false; 
  }
 
 void moveBy(PVector delta){
    position.add(delta); 
 }
 
 void updateSize(PVector delta, int mouseWheel){
   if(swatchWidth > 15 || delta.y < 0) {
     swatchWidth -= delta.y;
     swatchHeight -= delta.y;
   }
 }
 
 void setColor(color newColor) {
   fillColor = newColor;
 }
 
 void draw(){
   colorMode(RGB,255);
   if(selected){
     strokeWeight(2);
     stroke(255);
   }
   else{
     noStroke();
   }
   
   //colorMode(HSB, 100);
   //fill(hue,sat,bri);
   fill(fillColor);
   rectMode(CENTER);
   rect(position.x,position.y,swatchWidth,swatchHeight);
 }
 
}
