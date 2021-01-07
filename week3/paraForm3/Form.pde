class Form implements Comparable<Form> {
  int resolution = 20;
  float frequency = 0.1;
  float amplitude = 1.0;
  float vaseHeight = 500;
  float phase = 0;
  int rowNum = 50;
  
  float pVector[] = new float[5];

  Form(float[] pVector) {
   this.pVector = pVector;   
  }
  
  
  void mapVectorToParameters(){
     this.resolution = round(pVector[0]);
      this.frequency = pVector[1];
      this.amplitude =  pVector[2];
      this.vaseHeight =  pVector[3];
      this.phase =  pVector[4];
  }
  
  void drawForm(float x, float y, float scale) {
    lights();
    fill(255);
    strokeWeight(1);
    stroke(255);
    this.mapVectorToParameters();
    float quadHeight = vaseHeight/rowNum;

    Point3D[][] verticies = calculateVerticies(rowNum, quadHeight);
    pushMatrix();
    translate(x, y, 0);
    scale(scale,scale);
    rotateY((float)(frameCount * Math.PI / 400));
    beginShape(QUAD_STRIP);
    for (int i=1; i<verticies.length; i++) {
      Point3D[] pointListTop = verticies[i-1];
      Point3D[] pointListBottom = verticies[i];


      for (int j=0; j<=pointListTop.length; j++) {
        int t;
        if (j<pointListTop.length) {
          t = j;
        } else {
          t = 0;
        }
        Point3D bottom = pointListBottom[t];
        Point3D top = pointListTop[t];
        vertex(top.x, top.y, top.z);
        vertex(bottom.x, bottom.y, bottom.z);
      }
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

  Point3D[][] calculateVerticies(int rowNum, float quadHeight) {
    Point3D[][] verticies = new Point3D[rowNum][resolution];

    for (int i=0; i<rowNum; i++) {
      float y = quadHeight*i;
      float theta = map(i, 0, rowNum, 0, 8*PI);
      float r = (1+sin(theta*frequency+phase))*amplitude/2;
      Point3D[] pointList = calculatePoints(r*100, y, resolution);
      verticies[i] = pointList;
    }
    return verticies;
  }
  
  int compareTo(Form f) {
        float[] baseVector = getBaseVector();
        float d1 = euclidDistance(baseVector, this.pVector);
        float d2 = euclidDistance(baseVector, f.pVector);
        
        if(d1<d2){
          return -1;
        }
        else{

          return 1;
        }


    }
}
