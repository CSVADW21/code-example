class SeedSystem {
  ArrayList<Seed> seeds;
  PVector origin;
  PShape seedShape;
PVector stemCurvePosition;
int alpha;
float sd;

  SeedSystem(PShape _seedShape, PVector position, int seedCount, float _sd, int _alpha) {
    origin = position.copy();
    seeds = new ArrayList<Seed>();
    seedShape = _seedShape;
    seedShape.disableStyle();
    alpha = _alpha;
    sd = _sd;
    PVector gausVector = new PVector(randomGaussian(),randomGaussian());
     stemCurvePosition = gausVector.mult(100);
     generateSeeds();
  }

  void generateSeeds(){
     for(int i =0;i<seedCount;i++){
       this.addSeed(sd);  
     }
  }

  void addSeed(float sd) {
     float xVal = randomGaussian();
    float yVal = randomGaussian();
    PVector gauss = new PVector(xVal,yVal);
    PVector position = gauss.mult(sd).add(origin);
    PVector delta = origin.copy().sub(position);
    seeds.add(new Seed(delta,seedShape,alpha));
  }

  void update() {
    if(seeds.size()==0){
     generateSeeds(); 
    }
    pushMatrix();
      translate(origin.x,origin.y);
    drawStem();
    for (int i = seeds.size()-1; i >= 0; i--) {
      Seed s = seeds.get(i);
      
      
      s.run();
      
      if (s.isDead()) {
        seeds.remove(i);
      }
    }
    popMatrix();
  }
  
  
  void drawStem(){
    noFill();
    
    stroke(255,255,255,alpha);
          strokeWeight(2);

    beginShape();
      curveVertex(0, 0); // the first control point
      curveVertex(0, 0); // is also the start point of curve
      curveVertex(stemCurvePosition.x, (height-origin.y)/2);
      curveVertex(0, height-origin.y); // the last point of curve
      curveVertex(0, height-origin.y); // the last point of curve      
      endShape();
     

  }
}
