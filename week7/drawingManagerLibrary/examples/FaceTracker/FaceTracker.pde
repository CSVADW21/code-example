

/**
 * WhichFaceLineDrawing
 modified from Dan Shiffman's WhichFace OpenCV example
 */

import gab.opencv.*;
import processing.video.*;
import java.awt.*;
import drawing.library.*;
import processing.pdf.*;


Capture video;
OpenCV opencv;

// List of my Face objects (persistent)
ArrayList<Face> faceList;
ArrayList<DShape> shapes;
DrawingManager drawingManager;
// List of detected faces (every frame)
Rectangle[] faces;

// Number of faces detected over all time. Used to set IDs.
int faceCount = 0;

// Scaling down the video
int scl = 2;

boolean showVideo = false;
void setup() {
  size(640, 480);
  video = new Capture(this, width/scl, height/scl);
  opencv = new OpenCV(this, width/scl, height/scl);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);  
  
  faceList = new ArrayList<Face>();
  shapes = new ArrayList<DShape>();
  drawingManager = new DrawingManager(this);
  video.start();
  background(255);

}

void draw() {
  scale(scl);
  opencv.loadImage(video);

  
  
  detectFaces();

  // Draw all the faces
  if(showVideo){
    image(video, 0, 0 ); 
  }

  for (int i = 0; i < faces.length; i++) {
    noFill();
   
    //rect(faces[i].x*scl,faces[i].y*scl,faces[i].width*scl,faces[i].height*scl);
    
    DShape s = shapes.get(i);
   

    s.addVertex(faces[i].x+faces[i].width/2, faces[i].y+faces[i].height/2);
    //rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
    s.renderTransformation(this);
  }
  
  
}

void keyPressed() {
  if(key == ' '){
    drawingManager.savePDF();
  }
   if(key == 'c'){
    drawingManager.clear();
  }
  if(key == 'v'){
    showVideo = !showVideo;
    if(!showVideo){
      background(255);
    }
  }
}


void detectFaces() {
  
  // Faces detected in this frame
  faces = opencv.detect();
  
  // Check if the detected faces already exist are new or some has disappeared. 
  
  // SCENARIO 1 
  // faceList is empty
  if (faceList.isEmpty()) {
    // Just make a Face object for every face Rectangle
    for (int i = 0; i < faces.length; i++) {
      println("+++ New face detected with ID: " + faceCount);
      faceList.add(new Face(faceCount, faces[i].x,faces[i].y,faces[i].width,faces[i].height));
      faceCount++;
      //add new shape for each face
       drawingManager.stroke(255,0,0);
    drawingManager.strokeWeight(5);
      DShape s = drawingManager.addShape();
      shapes.add(s);
    }
  
  // SCENARIO 2 
  // We have fewer Face objects than face Rectangles found from OPENCV
  } else if (faceList.size() <= faces.length) {
    boolean[] used = new boolean[faces.length];
    // Match existing Face objects with a Rectangle
    for (Face f : faceList) {
       // Find faces[index] that is closest to face f
       // set used[index] to true so that it can't be used twice
       float record = 50000;
       int index = -1;
       for (int i = 0; i < faces.length; i++) {
         float d = dist(faces[i].x,faces[i].y,f.r.x,f.r.y);
         if (d < record && !used[i]) {
           record = d;
           index = i;
         } 
       }
       // Update Face object location
       used[index] = true;
       f.update(faces[index]);
    }
    // Add any unused faces
    for (int i = 0; i < faces.length; i++) {
      if (!used[i]) {
        println("+++ New face detected with ID: " + faceCount);
        faceList.add(new Face(faceCount, faces[i].x,faces[i].y,faces[i].width,faces[i].height));
        faceCount++;
        DShape s = drawingManager.addShape();
      shapes.add(s);
      }
    }
  
  // SCENARIO 3 
  // We have more Face objects than face Rectangles found
  } else {
    // All Face objects start out as available
    for (Face f : faceList) {
      f.available = true;
    } 
    // Match Rectangle with a Face object
    for (int i = 0; i < faces.length; i++) {
      // Find face object closest to faces[i] Rectangle
      // set available to false
       float record = 50000;
       int index = -1;
       for (int j = 0; j < faceList.size(); j++) {
         Face f = faceList.get(j);
         float d = dist(faces[i].x,faces[i].y,f.r.x,f.r.y);
         if (d < record && f.available) {
           record = d;
           index = j;
         } 
       }
       // Update Face object location
       Face f = faceList.get(index);
       f.available = false;
       f.update(faces[i]);
    } 
    // Start to kill any left over Face objects
    for (Face f : faceList) {
      if (f.available) {
        f.countDown();
        if (f.dead()) {
          f.delete = true;
        } 
      }
    } 
  }
  
  // Delete any that should be deleted
  for (int i = faceList.size()-1; i >= 0; i--) {
    Face f = faceList.get(i);
    if (f.delete) {
      faceList.remove(i);
      shapes.remove(i);
    } 
  }
}

void captureEvent(Capture c) {
  c.read();
}