class Pyramid {
  float distance;
  PVector[] positions; 


  Pyramid() {
    
  }


  void display() {
    
    pushMatrix();
    stroke(255);
    //fill(255);
    noFill();
    beginShape(TRIANGLE_STRIP);
    vertex(0, 100, 0);
    vertex(100, 0, 0);
    vertex(0, 0, 100);
    vertex(100, 0, 100);
    endShape(CLOSE);
    
    
   // box(100);
    
    popMatrix();
  }
}
