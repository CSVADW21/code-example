//pshape tiling
PShape tile; // creates an instance of a PShape object
PShape tile2;

float rW = 100;
float rH = 100;
float[] patternA = {0.5, 1, 0.25, 0.75};
float[] patternB = {1, 0.5, 0.75, 0.25};
float[] patternC = {0.75, 0.25, 1, 0.5};
float[] patternD = {0.25, 0.75, 0.5, 1};

float [][] patternList = {patternA, patternB, patternC, patternD};

void setup() {
  tile = loadShape("tile.svg"); 
  tile2 = loadShape("tile2.svg");
  
  // load the .svg file and assign it to your created PShape object. this step is important! 
  
  // make sure you have ALSO added your .svg file to the directory (assignmentName\data\title.svg). this step is also important!
  // to add the .svg file into the data folder, you can: 
    // 1) drag and drop the file into this editor. Processing will automatically create a data folder (if there isn't one already) with your file in it.
    // 2) manually create a folder named "data" and put your .svg in it. 
  // General Processing Note: the "data" folder is where all of your external files should be placed (if using).
    
  //if your program crashes (and it is a PShape related issue), make sure: 
    // 1) the .svg filename when calling loadShape() matches the filename in the data folder and
    // 2) you have actually added the file into the data folder

  size(800, 800);
  background(0);
  noFill();
  stroke(255);
  
  int patternIndex = 0;
  // first, using two nested for loops, we partition our canvas into a grid indexed by two variables (i and j)
  for (int j=0; j<height/rH; j++) {
    // this for loop partitions the height of the canvas into j rows of height rH for tiling
    // then, for each row (indexed by j), ...
    int t = 0;
    float[] targetPattern = patternList[patternIndex];
    patternIndex ++;
    if (patternIndex > patternList.length-1) {
      patternIndex = 0;
    }

    for (int i=0; i<width/rW; i++) {
      // this for loop partitions the width of the canvas into i columns of width rW for tiling
      // then, for each column (indexed by i), ...
      float v = targetPattern[t];
      float r = toQuadrant(v);
      
      // each grid square is indexed by column i and row j
      // to calculate the top left corner of each grid box to draw from, we use the coordinates (i*rw, j*rH)
      drawSeed(i*rW, j*rH, r); // because this function draws the pattern at column i and row j, this grid unfolds horizontally 
                               // (for each row index, every column gets drawn before moving to the next row)
      
      t++;
      if (t>targetPattern.length-1) {
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
  float tV = random(0,1);
  if(tV < 0.5){
    shape(tile,0,0,rW,rH); 
  }
  else{
   shape(tile2,0,0,rW,rH); 
  }
  // draws the PShape object at translated coordinates 0, 0 (or in untranslated coordinates -> x+rW/2, y+rH/2) of width rW and height rH
  popMatrix(); // restores the prior, pre-translated coordinate system (origin is back to 0, 0)
}
