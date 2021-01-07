import java.util.*;
import controlP5.*;

ControlP5 cp5;
Controller ringResSlider;
Controller freqSlider;
Controller amplitudeSlider;
Controller heightSlider;
Controller phaseSlider;

int resolution = 20;
int resMax = 20;
int resMin = 3;

float frequency = 0.1;
float freqMax = 0.2;
float freqMin = 0.1;

float amplitude = 1.0;
float ampMax = 4.0;
float ampMin = 1.0;

float vaseHeight = 500;
float heightMax = 500;
float heightMin = 100;

float phase = 0;
float phaseMax = 2*PI;
float phaseMin = 0;


int formCount = 25;
int gridSpacing = 200;

ArrayList<Form> forms = new ArrayList<Form>();

void setup() {
  size(1600, 1024, P3D);
  setupSliders();
  generateGallery();
}


void draw() {

  background(0);
  ortho();
  //draw parameterizable form
  float[] pVector = new float[]{resolution, frequency, amplitude, vaseHeight, phase};
  Form form = new Form(pVector);
  form.drawForm(300, 200,1.0);
  
  
  //draw gallery
  int rowNum = round(1000/gridSpacing);
  int colNum = round(formCount/rowNum);
  int count = 0;
  int offset = 600;
  
  for (int j=0; j<colNum; j++) {
    for (int i=0; i<rowNum; i++) {
      forms.get(count).drawForm(i*gridSpacing+gridSpacing/2+offset, j*gridSpacing, 0.30);
      count++;
    }
  }
}

void controlEvent(ControlEvent theEvent) {
  //println("got a control event from controller with id "+theEvent.getController().getId());
  generateGallery();
}

void generateGallery(){
   //generate gallery
  
  for (int i=0; i<formCount; i++) {
    
    /*int _resolution = round(random(resMin, resMax));
    float _frequency = random(freqMin, freqMax);
    float _amplitude = random(ampMin, ampMax);
    float _vaseHeight = random(heightMin, heightMax);
    float _phase = random(phaseMin, phaseMax);*/
    
    float sd = 5;
    int _resolution = round(randomGaussian()*sd+resolution);
    if(_resolution<resMin){
      _resolution = resMin;
      
    }
    else if(_resolution > resMax){
      _resolution = resMax;
    }
    float _frequency = 0.1;//randomGaussian()*sd+frequency;
    float _amplitude =  randomGaussian()*sd+amplitude;
    float _vaseHeight = randomGaussian()*sd+vaseHeight;
    float _phase = randomGaussian()*sd+phase;
    
    

    float[] pV = new float[]{_resolution, _frequency, _amplitude, _vaseHeight, _phase};
    Form f = new Form(pV);
    forms.add(f);
  }


  Collections.sort(forms); 
}

void setupSliders(){
  cp5 = new ControlP5(this);

  ringResSlider =  cp5.addSlider("resolution")
    .setPosition(25, 25)
    .setRange(resMin, resMax)
    ;

  freqSlider = cp5.addSlider("frequency")
    .setPosition(25, 25*2)
    .setRange(freqMin, freqMax)
    ;

  amplitudeSlider =  cp5.addSlider("amplitude")
    .setPosition(25, 25*3)
    .setRange(ampMin, ampMax);
    ;


  heightSlider = cp5.addSlider("vaseHeight")
    .setPosition(25, 25*4)
    .setRange(heightMin, heightMax)
    ;



  phaseSlider = cp5.addSlider("phase")
    .setPosition(25, 25*5)
    .setRange(phaseMin,phaseMax)
    ;
}
