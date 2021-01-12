//truchet tiling 1

float rW = 40;
float rH = 40;
float[] pattern = {1, 0.25, 0.5, 0.75};

void setup() {
  size(800, 800);
  background(0);
  noFill();

  stroke(255);
  
  // first, using two nested for loops, we partition our canvas into a grid indexed by two variables (i and j)
  for (int j=0; j<height/rH; j++) { 
    // this for loop partitions the height of the canvas into j rows of height rH for tiling
    // then, for each row (indexed by j), ...
    int t = 0;

    // check to see if row is even or odd
    if (j%2 !=0) {
      t = pattern.length/2;
    }

    for (int i=0; i<width/rW; i++) { 
      // this for loop partitions the width of the canvas into i columns of width rW for tiling
      // then, for each column (indexed by i), ...
      float v = pattern[t];
      float r = toQuadrant(v);
      println(v, degrees(r), i);
      
      // each grid square is indexed by column i and row j
      // to calculate the top left corner of each grid box to draw from, we use the coordinates (i*rw, j*rH)
      drawSeed(i*rW, j*rH, r); // because this function draws the pattern at column i and row j, this grid unfolds horizontally 
                               // (for each row index, every column gets drawn before moving to the next row)
      
      t++;
      if (t>pattern.length-1) {
        t = 0;
      }
    }
  }
}

void draw() {
}

float toQuadrant(float v) {
  if (v <=0.25) {
    return 2*PI*0.25;
  } else if (v >0.25 && v<=0.5) {
    return  2*PI*0.5;
  } else if (v >0.5 && v<=0.75) {
    return  2*PI*0.75;
  } else {
    return 2*PI;
  }
}

void drawSeed(float x, float y, float r) {
  pushMatrix(); // saves the current coordinate system to the stack (enables controlling the scope of matrix transformations)
  translate(x+rW/2, y+rH/2); // translates the origin of the coordinate system to a new position
  rotate(r); // multiplies the current transformation matrix by a rotation matrix, resulting in a rotation around the translated origin
  noFill();
  rectMode(CENTER); // draws the center of the rectangle at the coordinates specified (as opposed to the top left corner of the rectangle -> default draw mode)
  rect(0, 0, rW, rH); // draws the rectangle at the origin of the rotated coordinate system (rW/2, y+rH/2)
  fill(255);
  triangle(-rW/2, -rH/2, rW/2, -rH/2, -rW/2, rH/2);
  popMatrix(); // restores the prior, pre-translated coordinate system  (origin is back to 0, 0)
}
