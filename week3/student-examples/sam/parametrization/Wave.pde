class Wave {
  float distance;
  PVector[] positions; 
  int gridX = 300;
  int gridY = 300;


  Wave() {
  }


  void display() {

    pushMatrix();
    stroke(255);
    //fill(255);
    noFill();
    beginShape(QUAD_STRIP);
    //translate(-50,-50);
    for (int i = -gridX/2; i < gridX/2; i++) {
      for (int j = -gridY/2; j < gridY/2; j++) {
        //vertex(i*val3, j*val2, val1*sin(radians(i*5) + radians(j*5))/ (val4*sin(radians(i*j))));
        // vertex(i*val3 , j*val2, val1*sin(radians(i*5) + radians(j*5))/ (val4*sin(radians(i*5))));
        //vertex(i*val3, j*val2, val1*sin(radians(i*j*val4))/exp(i*j/1000));
        vertex(val3*i, val2*j, sqrt(40000 - pow((val3*i), 2) - pow((val2*j),2) ));
       // vertex(val3*i, val2*j, -sqrt(40000 - pow((val3*i), 2) - pow((val2*j),2) ));
      }
    }
    
for (int i = -gridX/2; i < gridX/2; i++) {
      for (int j = -gridY/2; j < gridY/2; j++) {
        //vertex(i*val3, j*val2, val1*sin(radians(i*5) + radians(j*5))/ (val4*sin(radians(i*j))));
        // vertex(i*val3 , j*val2, val1*sin(radians(i*5) + radians(j*5))/ (val4*sin(radians(i*5))));
        //vertex(i*val3, j*val2, val1*sin(radians(i*j*val4))/exp(i*j/1000));
        //vertex(val3*i, val2*j, sqrt(40000 - pow((val3*i), 2) - pow((val2*j),2) ));
        vertex(val3*i, val2*j, -sqrt(40000 - pow((val3*i), 2) - pow((val2*j),2) ));
      }
    }
    endShape();


    // box(100);

    popMatrix();
  }
}
