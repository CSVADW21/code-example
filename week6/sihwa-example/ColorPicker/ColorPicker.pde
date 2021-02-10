// Create a novel color picker
//
// Sihwa Park
// Media Arts and Technology
// sihwapark@ucsb.edu
// 11/05/2019
// 

/* 
Networked color mixer

This color picker consists of principal color nodes 
and gradient edges between nodes. The user can add 
principal color nodes by clicking on an empty space 
and make an edge by dragging from one node to another node.
The edge shows a gradient color spectrum based on the
colors of two end nodes. It is possible to add nodes for 
color stops with a left mouse click on an edge. 
With a right mouse click, the user can delete a node or an edge.
With keys and mouse dragging, the user can change the 
hue/saturation/brightness, radius, and position of a node.
*/

import java.util.*;
import controlP5.*;

ControlP5 cp5;
ArrayList<ColorNode> colorNodes;
ArrayList<GradientEdgeRect> edges;

ColorNode currentNode = null;
GradientEdgeRect currentEdge = null;

boolean hueChange = false;
boolean brightChange = false;
boolean saturationChange = false;
boolean radiusChange = false;
boolean move = false;
boolean drawConnector = false;

int gZIndex = 0;
boolean drawStroke = false;
int[] blendMode = { BLEND, ADD, SCREEN};
int blendModeIndex = 0;

color lastColor;

void setup() {
  
  size(900, 900, P3D);
  colorNodes = new ArrayList<ColorNode>();
  edges = new ArrayList<GradientEdgeRect>();
  
  cp5 = new ControlP5(this);
  cp5.addCheckBox("checkBox")
     .setPosition(10, 10)
     .setSize(20, 20)
     .setItemsPerRow(1)
     .setSpacingRow(10)
     .addItem("stroke", 0);
     
     
  List list = Arrays.asList("BLEND", "ADD", "SCREEN");
  cp5.addScrollableList("BlendMode")
      .setPosition(10, 40)
      .setSize(200, 100)
      .setBarHeight(20)
      .setItemHeight(20)
      .setType(ScrollableList.LIST)
      .addItems(list)
      .setValue(0)
      .open()
      .setOpen(false);
      
  cp5.addTextarea("txt")
      .setPosition(width - 150,10)
      .setSize(140, 220)
      .setFont(createFont("arial",12))
      .setLineHeight(14)
      .setColor(color(128))
      .setText("====How to Use====\n"
          + "Mouse without keys\n"
          + "- Left click: add a node\n"
          + "- Right click: delete a node/edge\n"
          + "- Select & Drag: make an edge\n\n"
          + "Keys with dragging\n"
          + "- R: change a radius\n"
          + "- H: change hue\n"
          + "- S: change saturation\n"
          + "- B: change brightness\n"
          + "- M: move a node\n\n"
           
          );
          
  colorMode(HSB, 255);
  lastColor = color(0, 255, 255);
}

void checkBox(float[] a) {
  drawStroke = (a[0] == 1.0); 
}
void BlendMode(int n) {
  blendModeIndex = n;
}

void draw() {
  colorMode(RGB,255);
  blendMode(BLEND);
  background(0);
  
  blendMode(blendMode[blendModeIndex]);
  for(int i = 0; i < edges.size(); i++) {
    edges.get(i).draw();
  }
  
  blendMode(BLEND);
  if(drawStroke) {
    stroke(255);
    strokeWeight(3);
  } else noStroke();
  
  for(int i = 0; i < colorNodes.size(); i++) {
    colorNodes.get(i).draw();
  }
  
  if(currentNode != null) {
    PVector m = new PVector(mouseX, mouseY);
    PVector v = PVector.sub(m, currentNode.pos);
    float angle = v.heading();
    
    if(hueChange || brightChange || saturationChange) {
      stroke(255);
      strokeWeight(3);
      point(currentNode.pos.x, currentNode.pos.y);
      strokeWeight(1);
      PVector endPoint = m;
      if(v.mag() >= currentNode.radius) {
        endPoint.x = currentNode.radius;
        endPoint.y = 0;
        endPoint.rotate(angle);
        endPoint.add(currentNode.pos);
      }
      
      line(currentNode.pos.x, currentNode.pos.y, endPoint.x, endPoint.y);
    }
    
    if(drawConnector) {   
      PVector sl = new PVector(currentNode.radius * 0.25, 0);
      sl.rotate(angle + PI * 0.5);
      PVector el = PVector.add(sl, m);
      sl.add(currentNode.pos);
      
      PVector sr = new PVector(currentNode.radius * 0.25, 0);
      sr.rotate(angle - PI * 0.5);
      PVector er = PVector.add(sr, m);
      sr.add(currentNode.pos);
      
      stroke(255);
      strokeWeight(1);
      beginShape(LINES);
      vertex(currentNode.pos.x, currentNode.pos.y, 0);
      vertex(sl.x, sl.y, 0);
      
      vertex(currentNode.pos.x, currentNode.pos.y, 0);
      vertex(sr.x, sr.y, 0);
      
      vertex(currentNode.pos.x, currentNode.pos.y, 0);
      vertex(mouseX, mouseY, 0);
      
      vertex(mouseX, mouseY, 0);
      vertex(el.x, el.y, 0);
      
      vertex(mouseX, mouseY, 0);
      vertex(er.x, er.y, 0);
      
      endShape();
      
      currentEdge.draw();
    }
  }
}

void mousePressed() {
  if(cp5.isMouseOver()) return;
  
  currentNode = nodesHitTest(mouseX, mouseY);
  if(currentNode == null) {
    currentEdge = edgesHitTest(mouseX, mouseY);
    
    if(currentEdge == null) {
      if(mouseButton == LEFT) {
        ColorNode cc = new ColorNode(mouseX, mouseY, 50, lastColor);
        colorNodes.add(cc);
        currentNode = cc;
      }
    } else {
      if(mouseButton == LEFT) {
        color c = get(mouseX, mouseY);
        ColorNode midNode = new ColorNode(mouseX, mouseY, 50, c);
        colorNodes.add(midNode);
        lastColor = midNode.c;
        
        GradientEdgeRect edge1 = new GradientEdgeRect(currentEdge.startNode, midNode, 0, 0, gZIndex++);
        GradientEdgeRect edge2 = new GradientEdgeRect(midNode, currentEdge.endNode, 0, 0, gZIndex++);
        
        edges.add(edge1);
        edges.add(edge2);
        
        currentEdge.startNode.removeEdge(currentEdge);
        currentEdge.startNode.addEdge(edge1);
        midNode.addEdge(edge1);
        
        midNode.addEdge(edge2);
        currentEdge.endNode.removeEdge(currentEdge);
        currentEdge.endNode.addEdge(edge2);
        
        int index = edges.indexOf(currentEdge);
        edges.remove(index);
      } else {
        currentEdge.startNode.removeEdge(currentEdge);
        currentEdge.endNode.removeEdge(currentEdge);
        
        int index = edges.indexOf(currentEdge);
        edges.remove(index);
      }
    }
  } else {
    lastColor = currentNode.c;
    
    if(mouseButton == RIGHT) {
      IntList removeIndice = new IntList();
      for(GradientEdgeRect edge : currentNode.edges) {
        int index = edges.indexOf(edge);
        if(index != -1) removeIndice.append(index);
      }
     
      removeIndice.sortReverse();
      for(int index : removeIndice) {
        edges.remove(index);
      }
      currentNode.removeAllEdges();
      
      int index = colorNodes.indexOf(currentNode);
      colorNodes.remove(index);
    } else {
      for(GradientEdgeRect edge : currentNode.edges) {
        edge.isSelected(true);
      }
      
      Collections.sort(edges);
    }
  }
}

void mouseDragged() {
  if(mouseButton == RIGHT) return;
  
  if(currentNode != null) {
    if(hueChange) currentNode.changeHue(mouseX, mouseY);
    else if(brightChange) currentNode.changeBright(mouseX, mouseY);
    else if(saturationChange) currentNode.changeSaturation(mouseX, mouseY);
    else if(radiusChange) currentNode.changeRadius(mouseX, mouseY);
    else if(move) {
      PVector delta = new PVector(mouseX-pmouseX,mouseY-pmouseY);
      currentNode.move(delta);
    } else if(!drawConnector) {
      drawConnector = true;
      
      GradientEdgeRect edge = new GradientEdgeRect(currentNode, null, mouseX, mouseY, gZIndex++);
      currentEdge = edge;
    }
    
    if(drawConnector) {
      currentEdge.setEndMid(mouseX, mouseY);
      ColorNode node = nodesHitTest(mouseX, mouseY);
      if(node == null) {
        currentEdge.setEndColor(currentNode.c);
      } else if(node != currentNode) {
        currentEdge.setEndColor(node.c);
      }
    }
    
    lastColor = currentNode.c;
  }
}

void mouseReleased() {
  if(drawConnector) {
    ColorNode node = nodesHitTest(mouseX, mouseY);
    if(node != null && node != currentNode) {
      if(currentNode.hasEdgeWith(node) == false) {
        currentEdge.setEndNode(node);
      
        edges.add(currentEdge);
        currentNode.addEdge(currentEdge);
        node.addEdge(currentEdge);
      }
    }
  }
  
  currentNode = null;
  drawConnector = false;
  currentEdge = null;
}

void keyPressed() {
  if(drawConnector) return;
  
  if(key == 'h') {
    hueChange = true;
  } else if(key == 's') {
    brightChange = true;
  } else if(key == 'b') {
    saturationChange = true;
  } else if(key == 'm') {
    move = true;
  } else if(key == 'r') {
    radiusChange = true;
  } else if(key == ' ') {
    save("screenshot.png");
  }
}

void keyReleased() {
  hueChange = false;
  brightChange = false;
  saturationChange = false;
  move = false;
  radiusChange = false;
}

ColorNode nodesHitTest(int x, int y) {
  for(ColorNode node : colorNodes) {
    boolean hit = node.hitTest(x, y);
    if(hit) {
      return node;
    }
  }
  
  return null;
}

GradientEdgeRect edgesHitTest(int x, int y) {
  for(GradientEdgeRect edge : edges) {
    boolean hit = edge.hitTest(x, y);
    println(hit);
    if(hit) {
      return edge;
    }
  }
  
  return null;
}
