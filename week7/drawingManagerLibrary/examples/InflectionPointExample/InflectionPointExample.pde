import drawing.library.*;
import processing.pdf.*;

DrawingManager drawingManager;
DShape shape;
void setup() {
  size(1056,816,P3D);
  background(255);
  smooth();
  drawingManager = new DrawingManager(this);
  shape = drawingManager.addShape(); 

 }

void draw() {
}

void keyPressed() {
  if(key == ' '){
    drawingManager.savePDF();
  }
   if(key == 'c'){
    drawingManager.clear();
  }
}

void mousePressed(){
   shape = drawingManager.addShape(); 
   drawingManager.stroke(0,0,0);
   shape.addVertex(mouseX,mouseY); 
 
}

void mouseReleased(){
  ArrayList<DPoint> smoothedVerticies = new ArrayList<DPoint>();
  for(int i=0;i<shape.vertices.size();i+=1){
       smoothedVerticies.add(shape.vertices.get(i)); 
  }
 ArrayList<InflectionPoint> ips = calculateInflectionPoints(smoothedVerticies); 
 for(int i=0;i<ips.size();i++){
   if(ips.get(i).dir == 1){
     stroke(255,0,0);
   }
   else if(ips.get(i).dir == 0){
     stroke(0,0,255);

   }
   else{
     stroke(0);
   }
     drawingManager.strokeWeight(1);
 DShape line =  drawingManager.addShape();
 float inc = 1;
 line.addVertex(ips.get(i).point.x,ips.get(i).point.y+2);
 DPoint p = line.position;
 println("intersection check for", i,p.y,height);
 while(!intersectionCheck(p,shape.vertices,1) && p.y<height){
   line.addVertex(p.x,p.y);
   println(p.y,height);
   p = new DPoint(ips.get(i).point.x,p.y+inc);
 }
 }
}
  
void mouseDragged(){
    drawingManager.stroke(0,0,0);
   shape.addVertex(mouseX,mouseY); 
}


boolean intersectionCheck(DPoint c,ArrayList<DPoint>vertices,float threshold){
  for(int i =1;i<vertices.size();i++){
      DPoint a = vertices.get(i-1);
      DPoint b = vertices.get(i);
      Float distAC = new PVector(a.x-c.x,a.y-c.y).mag();
       Float distBC = new PVector(b.x-c.x,b.y-c.y).mag();
       Float distAB = new PVector(a.x-b.x,a.y-b.y).mag();
       if (abs(distAC + distBC - distAB)<threshold){
    
        
        return true;
      }
  }
  return false;
}


ArrayList<InflectionPoint> calculateInflectionPoints(ArrayList<DPoint> dataset) {
      println("calculate inflection");

    ArrayList<Float> der = new ArrayList<Float>();
    ArrayList<InflectionPoint> inflections = new ArrayList<InflectionPoint>();
   inflections.add(new InflectionPoint(dataset.get(0),-1));
    for (int i = 1; i < dataset.size(); i++) {
      float x_t = dataset.get(i).y;
      float x_t_1 = dataset.get(i-1).y;
      float delta_t = dataset.get(i).x - dataset.get(i - 1).x;
      float y_t = (x_t - x_t_1) / delta_t;
      der.add(y_t);
      if (i > 1) {
        float y_t_1 = der.get(i - 2);
        if (y_t == 0) {
  //do nothing
        } else {
          if (y_t>0 && y_t_1 >= 0) {
            println("less than",y_t,",",y_t_1);
            inflections.add(new InflectionPoint(dataset.get(i),0));
          } else if (y_t>0 && y_t_1 <= 0) {
               println("greater than",y_t,",",y_t_1);
            inflections.add(new InflectionPoint(dataset.get(i),1));
          }
        }
      }
    }
    inflections.add(new InflectionPoint(dataset.get(dataset.size()-1),-1));
    return inflections;
 }
  
  
class InflectionPoint {
   DPoint point;
   int dir;
   
   InflectionPoint(float x,float y,int dir){
     this.point = new DPoint(x,y);
     this.dir = dir;
   }
    InflectionPoint(DPoint point,int dir){
     this.point = new DPoint(point.x,point.y);
     this.dir = dir;
   }
  
}