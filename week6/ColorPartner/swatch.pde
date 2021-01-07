class Swatch{
 float rad;
 PVector position;
 int hue;
 int sat;
 int bri;
 int order;
 boolean selected;
 boolean locked = false;
 
 Swatch(int x,int y, float r, int h, int s, int b){
  position = new PVector(x,y);
   rad = r;
   hue = h;
   sat = s;
   bri = b;
   selected = false;
 }
 
  boolean hitTest(int x,int y){
    if(pow(x - position.x,2) + pow(y - position.y,2) < pow(rad,2)){
      return true;
      
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
   ellipseMode(CENTER);
   ellipse(position.x,position.y,rad,rad);
   if(locked == false){
     rad -=0.015;
   }
 }
 
}
