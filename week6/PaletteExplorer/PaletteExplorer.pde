Swatch swatch1;
Swatch swatch2;
Swatch swatch3;

ArrayList<Swatch> swatches; 
boolean colorShift = false;

void setup(){
  size(800,800);
  swatches = new ArrayList<Swatch>();
  swatch1 = new Swatch(100,100,500,500);
  swatch2 = new Swatch(500,100,300,100);
  swatch3 = new Swatch(400,200,200,200);
  swatches.add(swatch1);
  swatches.add(swatch2);
  swatches.add(swatch3);

}

void draw(){
  colorMode(RGB,255);
  background(200,200,200);
  for(int i=0;i<swatches.size();i++){
    swatches.get(i).draw();
  }
 
}

void mousePressed(){
  for(int i= swatches.size()-1;i>=0;i--){
   Swatch s = swatches.get(i);
   boolean hitTest = s.hitTest(mouseX,mouseY);
   
   if(hitTest == true){
      s.selected = true; 
      println("selected",i);
      return;
   }
  } 
}

void keyPressed(){
 colorShift = true; 
}

void keyReleased(){
  colorShift = false;
}

void mouseReleased(){
  deselectAllSwatches();
}

void mouseWheel(MouseEvent event) {
  int e = round(event.getCount());
 for(int i=0;i<swatches.size();i++){
     Swatch s = swatches.get(i);
     if(s.selected == true){
       if(colorShift == true){
         s.updateColor(new PVector(0,0),e);
       }
       return;
     }  
   }
}

void mouseDragged(){
   PVector delta = new PVector(mouseX-pmouseX,mouseY-pmouseY);
   for(int i=0;i<swatches.size();i++){
     Swatch s = swatches.get(i);
     if(s.selected == true){
       if(colorShift == false){
          s.moveBy(delta);
       }
       else{
         s.updateColor(delta,0);
       }
       return;
     }  
   }   
}

void deselectAllSwatches(){
   for(int i=0;i<swatches.size();i++){
      swatches.get(i).selected = false;
   }
}
