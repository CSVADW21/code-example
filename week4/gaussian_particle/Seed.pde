class Seed {
  PShape seedShape;

  PVector position;
  PVector velocity;
  PVector acceleration;
  float scale;
  int alpha;

  Seed(PVector l, PShape _seedShape, int _alpha) {
    acceleration = new PVector(0, 0.05);
    velocity = l.copy().normalize();
    position = l.copy();
    scale = 1;
    alpha = _alpha;
    seedShape = _seedShape;
  }

  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    position.add(velocity);
    float mag = position.mag();
    scale =  map(mag, 0,300,1.5,0.1);
  }



  // Method to display
  void display() {
    float theta = position.heading();
    pushMatrix();
    translate(position.x,position.y);
    rotate(theta);
    scale(scale,scale);
    fill(255,255,255,alpha);
    noStroke();
    shape(seedShape,0,0);
    popMatrix();  
  }

  // Is the particle still useful?
  boolean isDead() {
    if (scale < 0.1) {
      return true;
    } else {
      return false;
    }
  }
}
