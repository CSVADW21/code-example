PVector p2;
PVector p1;
float stepSize = 1;
float noiseScale = 100; 
float noiseStrength = 10;

float noiseZ, noiseZVelocity = 0.01;
float angle;
float strokeWidth = 0.3;

int formResolution = 15;
float distortionFactor = 1;
float initRadius = 150;
float[] x = new float[formResolution];
float[] y = new float[formResolution];


void setup(){
  size(600,600);
  p2 = new PVector(width/2, height/2);
  p1 = p2.copy();
  
  //calculate intial coordinates for form
  float angle = radians(360/float(formResolution));
  for (int i=0; i<formResolution; i++){
    x[i] = cos(angle*i) * initRadius;
    y[i] = sin(angle*i) * initRadius;  
  }
  
  smooth();
 // frameRate(4);
  background(0);
  
}

void draw(){
  fill(0, 4);
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
    
     // calculate new points
  for (int i=0; i<formResolution; i++){
    x[i] += random(-stepSize,stepSize);
    y[i] += random(-stepSize,stepSize);
    // ellipse(x[i], y[i], 5, 5);
  }
    
    strokeWeight(0.75);
    noFill();
    
    beginShape();
  // start controlpoint
  curveVertex(x[formResolution-1]+p2.x, y[formResolution-1]+p2.y);

  // only these points are drawn
  for (int i=0; i<formResolution; i++){
    curveVertex(x[i]+p2.x, y[i]+p2.y);
  }
  curveVertex(x[0]+p2.x, y[0]+p2.y);

  // end controlpoint
  curveVertex(x[1]+p2.x, y[1]+p2.y);
  endShape();
    

    p1.set(p2);
    noiseZ += noiseZVelocity;

}
