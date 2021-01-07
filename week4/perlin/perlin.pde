PVector p;
PVector pOld;
float stepSize = 1;
float noiseScale = 100; 
float noiseStrength = 10;

float noiseZ, noiseZVelocity = 0.01;
float angle;
float strokeWidth = 0.3;

void setup(){
  size(600,600);
  p = new PVector(width/2, height/2);
  pOld = p.copy();
  smooth();
 // frameRate(4);
  background(0);
  
}

void draw(){
  fill(0, 10);
  noStroke();
  rect(0,0,width,height);

  stroke(255, 90);
  
    angle = noise(p.x/noiseScale, p.y/noiseScale, noiseZ) * noiseStrength;
    p.x += cos(angle) * stepSize;
    p.y += sin(angle) * stepSize;
    
    // offscreen wrap
    if (p.x<-10) p.x=pOld.x=width+10;
    if (p.x>width+10) p.x=pOld.x=-10;
    if (p.y<-10) p.y=pOld.y=height+10;
    if (p.y>height+10) p.y=pOld.y=-10;
    
    strokeWeight(3);
    line(pOld.x,pOld.y, p.x,p.y);

    pOld.set(p);
    noiseZ += noiseZVelocity;

}
