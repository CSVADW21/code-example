/*******************************
*  Stroke Drawing with Mic Input
*  This example demonstrates how you can draw 
*  strokes responding to the real-time microphone input.
*
*  Author: Sihwa Park
*  Email: sihwapark@ucsb.edu
*  11/12/2019
*******************************/


import ddf.minim.*;
import ddf.minim.analysis.*;
import soundBrush.*;

Minim minim;
AudioInput in;
FFT fft;

int resolution = 50;
float cx, cy;
float z = 0;
float spectrumScaleFactor = 10.0f;
float startAngle = 0;
float minHue = 0;
float maxHue = 255;
float minStrokeWidth = 10;
float maxStrokeWidth = 50;
float[] fftBands = new float[resolution];

boolean showWireFrame = false;
ArrayList<SoundBrushStroke> soundBrushStrokes;
SoundBrushStroke lastStroke;

void setup()
{
  size(500, 500, P3D);
  
  soundBrushStrokes = new ArrayList<SoundBrushStroke>();
  
  minim = new Minim(this);
  in = minim.getLineIn();
  fft = new FFT(in.bufferSize(), in.sampleRate());
  fft.window(FFT.HAMMING);
  //fft.linAverages(resolution);
  fft.logAverages(22, resolution / 10);
}

void mousePressed() {
  SoundBrushStroke stroke = new SoundBrushStroke();
  soundBrushStrokes.add(stroke);
  lastStroke = stroke;
  lastStroke.addVertex(mouseX, mouseY, z, resolution, fftBands, spectrumScaleFactor, startAngle);
}

void mouseDragged() {
  if(lastStroke != null)
      lastStroke.addVertex(mouseX, mouseY, z, resolution, fftBands, spectrumScaleFactor, startAngle);
}

void keyPressed() {
  if(key == 'c') {
    soundBrushStrokes.clear();
    lastStroke = null;
  } else if(key == 'w') {
     showWireFrame = !showWireFrame;
  }
}

void draw() {
  background(0);
  fft.forward(in.mix);
  
  for (int i = 0; i < fft.avgSize(); i++) {
    fftBands[i] = fft.getAvg(i);
  }
  
  drawStrokes();
}

public void drawStrokes() {
    if (showWireFrame) {
      colorMode(RGB, 255);
      stroke(255, 100);
    } else
      noStroke();

    for (SoundBrushStroke brushStroke : soundBrushStrokes) {
      brushStroke.draw(this);
    }
  }
