class Intestinal {
  ArrayList<PVector> position  = new ArrayList<PVector>();
  ArrayList<PVector> diameter  = new ArrayList<PVector>();
  float number;

  Intestinal() {
  }

  void display() {
    noFill();
   // stroke(255, val5);

    beginShape();
    for (int i = 0; i < 1000; i++) {
      if (i < 3) {
        //stroke(255, 0);
        noStroke();
      } else {
        stroke(shapeColor, val5);
      }
      ellipse(0, 0, val1/(1+val4*i), val1/(1+val4*i));
      //ellipse(0, 0, val1*sin(i/10.), val1*sin(i/10.));
      translate(0, 0, val1/10);
      rotateX(val2*sin(i));
      rotateY(val3*sin(i));
    }
    /*ellipse(0, 10, val2, val2);
     translate(0,0,20);
     ellipse(0, 12, val3, val3);*/
    //addCircle(new PVector(0, 0, 0), new PVector(0, 0, 0));

    endShape();
  }

  void addCircle(PVector trans, PVector rot) {

    pushMatrix();
    translate(trans.x, trans.y, trans.z);
    /*rotateX(rot.x);
     rotateY(rot.y);
     rotateZ(rot.z);*/
    ellipse(0, 0, 200, 200);
    popMatrix();

    if (number < 50) {
      number++;
      println("yoooo");
      addCircle(new PVector(trans.x+10, trans.y+100, trans.z+10), new PVector(rot.x+0.1, rot.y, rot.z));
    }
  }
}
