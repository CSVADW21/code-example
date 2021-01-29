
int resolution = 20;

float frequency = 0.1;
float amplitude = 1.0;
float vaseHeight = 500;
float phase = 0;


void setup() {
  size(1024, 768, P3D);

}


void draw() {
int rowNum = 50;
float quadHeight = vaseHeight/rowNum;

  background(0);
  lights();
  pushMatrix();
  translate(width / 2, height / 2 - rowNum*quadHeight / 2 , -100);
  fill(255);
  stroke(0,0,255);
  strokeWeight(1);
  rotateY((float)(frameCount * Math.PI / 400));
  
  
  float r = 200;
  float y = 100;
  
  Point3D[] pointList = calculatePoints(r, y, resolution);
    
    
  beginShape(QUAD_STRIP);
   for (int j=0; j<=pointList.length; j++) {
      int t;
      if (j<pointList.length) {
        t = j;
      } else {
        t = 0;
      }
      Point3D top = pointList[t];
      vertex(top.x, top.y, top.z);
      vertex(top.x, top.y+100, top.z);
    }
  endShape(CLOSE);

  popMatrix();
}


Point3D[] calculatePoints(float r, float y, int res) {
  Point3D [] pointList = new Point3D[res];
  for (int i =0; i<res; i++) {
    float theta = 2*PI/res*i;
    float x = cos(theta)*r;
    float z = sin(theta)*r;
    Point3D p = new Point3D(x, y, z);
    pointList[i] = p;
  }

  return pointList;
}
