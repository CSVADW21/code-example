//truchet tiling 1

float rW = 40;
float rH = 40;
float[] pattern = {1,0.25,0.5,0.75};


void setup(){
  size(800,800);
  background(0);
  noFill();
  
  stroke(255);
  
    for(int j=0;j<height/rH;j++){
      int t = 0;
      
     //check to see if row is even or odd
      if(j%2 !=0){
        t = pattern.length/2;
      }
      
     for(int i=0;i<width/rW;i++){
      float v = pattern[t];
      float r = toQuadrant(v);
      println(v,degrees(r),i);
      drawSeed(i*rW,j*rH,r);
      t++;
      if(t>pattern.length-1){
        t = 0;
      }

    }
  }
}

void draw(){
  
}

float toQuadrant(float v){
  if(v <=0.25){
    return 2*PI*0.25;
  }
  else if(v >0.25 && v<=0.5){
    return  2*PI*0.5;
  }
  else if(v >0.5 && v<=0.75){
    return  2*PI*0.75;
  }
  else{
     return 2*PI;
  }
}

void drawSeed(float x, float y,float r){
  pushMatrix();
   translate(x+rW/2,y+rH/2);
   rotate(r);
   noFill();
   rectMode(CENTER);
   rect(0,0,rW,rH); 
   fill(255);
   triangle(-rW/2,-rH/2,rW/2,-rH/2,-rW/2,rH/2);
 popMatrix();
  
}
