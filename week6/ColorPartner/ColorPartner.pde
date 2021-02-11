Swatch swatch1;
Swatch swatch2;

ArrayList<Swatch> swatches; 
Swatch selectedSwatch;
boolean colorShift = false;
boolean move = false;

int framesElapsed = 0;

void setup(){
  size(800,800);
  swatches = new ArrayList<Swatch>();
  swatch1 = new Swatch(round(width*0.3),height/2,100,0,100,100);
  swatch2 = new Swatch(round(width*0.6),height/2,100,10,100,100);
  swatch1.locked = true;
  swatch2.locked = true;
  swatches.add(swatch1);
  swatches.add(swatch2);
  


}

void draw(){
  colorMode(RGB,255);
  background(200,200,200);
  
  for(int i=0;i<swatches.size();i++){
    swatches.get(i).draw();
   
  }
  
  for(int i=swatches.size()-1;i>=0;i--){
    if(swatches.get(i).rad<0){
      swatches.remove(i);
    }
   
  }
  
  
  if(selectedSwatch != null && colorShift == false && move == false){
   
    colorMode(RGB,255);
    stroke(255);
    line(selectedSwatch.position.x,selectedSwatch.position.y,mouseX,mouseY);
    framesElapsed ++;
    if(framesElapsed > 100){
      generateVariations(selectedSwatch,mouseX,mouseY);
      framesElapsed = 0;
    }
  }
 
}



void keyPressed(){
  if(key == 'c'){
   colorShift = true;
  }
  else if(key == 'm'){
    move = true;
  }
}

void keyReleased(){
  colorShift = false;
  move = false;
}

void mouseReleased(){
  deselectAllSwatches();
  framesElapsed = 0;
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
       if(colorShift == true){
         s.updateColor(delta,0);
       }
       else if(move == true){
         s.moveBy(delta);
       }
       return;
     }  
   }   
}


void mousePressed(){
  Swatch s = checkForSwatchHit(mouseX,mouseY);
  if(s != null && s.locked){
    println("swatch selected");
     s.selected = true;
    selectedSwatch = s;
       s.rad = 75;
  }
}


void deselectAllSwatches(){
   for(int i=0;i<swatches.size();i++){
      swatches.get(i).selected = false;
   }
   selectedSwatch = null;
}

Swatch checkForSwatchHit(int x,int y){
  println("swatch length",swatches.size());
   for(int i=swatches.size()-1;i>=0;i--){
   Swatch s = swatches.get(i);
   boolean hitTest = s.hitTest(x,y);
   
   if(hitTest == true){
     println("hit",i);
     s.locked = true;
       return s;
   }
  } 
  return null;
}

void generateVariations(Swatch targetSwatch, int x, int y){
   PVector diffVec = new PVector(x-targetSwatch.position.x,y-targetSwatch.position.y);
   float dist = map(diffVec.mag(),0,width/2,0,40);
   if(dist>40){
     dist = 40;
   }
   if(dist<0){
     dist = 0;
   }
   int startHue = targetSwatch.hue;
   int startSat = targetSwatch.sat;
   int startBri = targetSwatch.bri;
   
   int newHue = round(randomGaussian()*dist+startHue);
   int newSat = round(randomGaussian()*dist+startSat);
   int newBri = round(randomGaussian()*dist+startBri);

   //println(newHue,startHue,newSat,startSat, newBri,startBri);
   Swatch newSwatch = new Swatch(x,y,40,newHue,newSat,newBri);
   swatches.add(newSwatch);
}
