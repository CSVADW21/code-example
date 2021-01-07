/**
 * Serial Read Brush
 * 
 * example of a repeating brush that modulates 
 * line delta based on incoming serial values
 */


import drawing.library.*;
import processing.pdf.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class
float val;      // Data received from the serial port

//instance of DrawingManager library
DrawingManager drawingManager;


//total number of lines to be drawn
int linecount = 12;
//speed at which lines traverse across the canvas
float speed = 0.5;
//rate at which to vary the change in delta
float deltaRange = 3;
//list of shapes
ArrayList<DShape> shapes = new ArrayList<DShape>();
void setup() {
  size(792,612,P3D);
  
  background(255);
  smooth();
  //initialize DrawingManager
  drawingManager = new DrawingManager(this);
  
  // Setup the serial connection
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[1];
  myPort = new Serial(this, portName, 9600);
   // don't generate a serialEvent() unless you get a newline character:
  myPort.bufferUntil('\n');
  
 }

//save and clear functions
void keyPressed() {
  if(key == ' '){
    drawingManager.savePDF();
  }
  if(key == 'c'){
  	drawingManager.clear();
  }
}



void mouseReleased(){
}

void draw(){
  //set the stroke to black
   drawingManager.stroke(0,0,0);
   
  //map the incoming sensor value to a range between -1 and 1;   
    float d = map(val,0.0,1023.0,-1.0,1.0);
    
   //loop through the first half of the shapes
   for(int i = 0; i<floor(shapes.size()/2);i++){
     //map the sensor value multiplied by i to a range between -deltaRange and delta Range)
     float mappedD = map(d*i,-linecount,linecount,-deltaRange,deltaRange);
     DShape shape = shapes.get(i);
     
     // set the shape x delta to the mapped value and the shape y value to -speed
     // This produces an effect where the greater the value of i, the greater
     // change in delta
     float x = mappedD;
     float y = -speed;
     shape.addDelta(x,y);
   }
   //perform the same action for the second half of the shapes
   // but set the x to -delta to oscillate the lines in the reverse direction
    for(int i = 0; i<floor(shapes.size()/2);i++){
      
     float mappedD = map(d*i,-linecount,linecount,-deltaRange,deltaRange);
     DShape shape = shapes.get(i+floor(shapes.size()/2));
     float x = -mappedD;
     float y = -speed;
     shape.addDelta(x,y);
   }
 
 }
 
 
 void mousePressed(){
  //clear all existing shapes
  shapes.clear();
  //use a loop to create a new set of shapes
  
  for(int i = 0; i<linecount;i++){
     //initialize a new DShape object
    DShape s = drawingManager.addShape(); 
    //add it to the list of shapes
    
    shapes.add(s);
    s.addVertex(mouseX,mouseY);
  }
}
//function that gets called whenever serial data is sent over.
void serialEvent(Serial myPort) {
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);
     
    //float[] vals = float(split(inString, ','));
     val = float(inString);
     println(val);
    }
  
}

/*//Arduino Code

// the setup routine runs once when you press reset:
void setup() {
  // initialize serial communication at 9600 bits per second:
  Serial.begin(9600);
}

// the loop routine runs over and over again forever:
void loop() {
  // read the input on analog pin 0:
  int sensorValue = analogRead(A0);
  // print out the value you read:
  Serial.println(sensorValue);
  delay(100);        // delay in between reads for stability
}


*/
   