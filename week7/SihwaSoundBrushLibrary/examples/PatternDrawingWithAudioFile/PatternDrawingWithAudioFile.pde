/*******************************
*  Pattern Drawing with Audio File
*  This example demonstrates how you can visualize
*  the frequency spectrum of a real-time audio signal 
*  as a circluar pattern.
*
*  Author: Sihwa Park
*  Email: sihwapark@ucsb.edu
*  11/12/2019
*******************************/

import ddf.minim.*;
import ddf.minim.analysis.*;
import soundBrush.*;

Minim       minim;
AudioPlayer player;
FFT         fft;

int resolution = 50;
float cx, cy;
float z = 0;
float spectrumScaleFactor = 10.0f;
float startAngle = 0;
float minRadius = 10;
float maxRadius = 100;
float[] fftBands = new float[resolution];

SoundBrushCirclePattern pattern;

void setup()
{
  size(300, 300, P3D);

  cx = width / 2;
  cy = height / 2;
  
  pattern = new SoundBrushCirclePattern(resolution, cx, cy, z, spectrumScaleFactor, startAngle);
  pattern.setSpectrumRange(minRadius, maxRadius);
  
  minim = new Minim(this);
  player = minim.loadFile("beat.wav", 2048);
  player.loop();
  
  fft = new FFT(player.bufferSize(), player.sampleRate());
  //fft.window(FFT.HAMMING);
  fft.linAverages(resolution);
  //fft.logAverages(22, resolution / 10);
}

void draw() {
  background(0);
  fft.forward(player.mix);
  
  for (int i = 0; i < fft.avgSize(); i++) {
    fftBands[i] = fft.getAvg(i);
  }
  
  pattern.update(fftBands);
  ArrayList<PVector> points = pattern.points;
  
  fill(255);
  beginShape();
  for(PVector p: points) {
    vertex(p.x + cx, p.y + cy, p.z);
  }
  vertex(points.get(0).x + cx, points.get(0).y + cy, points.get(0).z);
  endShape();
}
