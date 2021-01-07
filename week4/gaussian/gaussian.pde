PShape seed;
int seedWidth = 200;
int seedHeight = 325;
int seedCount = 100;

void setup() {
  size(1000, 1000);
  seed = loadShape("seed.svg");

  noLoop();
}

void draw() {
  background(0);
  dandelion(200, 80, 200, 200);
}


void dandelion(int seedCount, float sd, int xMean, int yMean) {
  for (int i =0; i<seedCount; i++) {
    // Get a gaussian random number w/ mean of 0 and standard deviation of 1.0   
    float xVal = randomGaussian();
    float yVal = randomGaussian();

    float x = ( xVal * sd ) + xMean;
    float y = ( yVal * sd ) + yMean;  // Scale the gaussian random number by standard deviation and mean
    PVector origin = new PVector(xMean, yMean);
    PVector delta = new PVector(xMean-x, yMean-y);

    float theta = delta.heading();

    float r = delta.mag();
    float scale = map(r, 0, 200, 1.5, 0.15);

    stroke(255, 0, 0);
    pushMatrix();
    translate(x, y);
    rotate(theta+radians(180));
    scale(scale, scale);
    shape(seed, 0, 0, seedWidth, seedHeight);
    popMatrix();
  }
}
