class Swatch{
 int swatchWidth;
 int swatchHeight;
 PVector position;
 int hue;
 int sat;
 int bri;
 int order;
 boolean selected;
 
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
    if(x>= position.x && x<=position.x+swatchWidth){
      
      if(y>= position.y&& y<=position.y+swatchHeight){
      return true;
      
      }
    }
    return false; 
  }
 
 void moveBy(PVector delta){
    position.add(delta); 
 }
 
 void updateColor(PVector delta, int mouseWheel){
   hue += delta.y;
   sat += delta.x;
   bri += mouseWheel;

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
   
   colorMode(HSB, 100);
   fill(hue,sat,bri);
   rect(position.x,position.y,swatchWidth,swatchHeight);
 }
 
}
