PVector p2;
PVector p1;
float stepSize = 1;
float noiseScale = 100; 
float noiseStrength = 10;

float noiseZ, noiseZVelocity = 0.01;
float angle;
float strokeWidth = 0.3;

void setup(){
  size(600,600);
  p2 = new PVector(width/2, height/2);
  p1 = p2.copy();
  smooth();
 // frameRate(4);
  background(0);
  
}

void draw(){
  fill(0, 10);
  noStroke();
  rect(0,0,width,height);

  stroke(255, 90);
  
    angle = noise(p2.x/noiseScale, p2.y/noiseScale, noiseZ) * noiseStrength;
    
    PVector aV = new PVector(cos(angle) * stepSize,sin(angle) * stepSize);
    p2.add(aV);
    
    // offscreen wrap
    if (p2.x<-10) p2.x=p1.x=width+10;
    if (p2.x>width+10) p2.x=p1.x=-10;
    if (p2.y<-10) p2.y=p1.y=height+10;
    if (p2.y>height+10) p2.y=p1.y=-10;
    
    strokeWeight(3);
    line(p1.x,p1.y, p2.x,p2.y);

    p1.set(p2);
    noiseZ += noiseZVelocity;

}
