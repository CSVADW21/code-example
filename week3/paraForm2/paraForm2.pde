import java.util.*;

int formCount = 30;
int gridSpacing = 160;
Form[] forms = new Form[formCount];

void setup() {
  size(1024, 768, P3D);
  

  for(int i=0;i<formCount;i++){
    int resolution = round(random(3,20));
  float frequency = random(0.1,0.15);
  float amplitude = random(1.0,4.0);
  float vaseHeight = random(100,500);
  float phase = random(0,2*PI);
  float[] pVector = new float[]{resolution,frequency,amplitude,vaseHeight,phase};
    Form form = new Form(pVector);
    forms[i] = form;
  }
 
 
}


void draw() {

  background(0);
   ortho();
   int rowNum = round(width/gridSpacing);
   int colNum = round(formCount/rowNum);
  int count = 0;
   for(int j=0;j<colNum;j++){
     for(int i=0;i<rowNum;i++){
        forms[count].drawForm(i*gridSpacing+gridSpacing/2,j*gridSpacing,0.30);
        count++;  
   } 
   }

}
