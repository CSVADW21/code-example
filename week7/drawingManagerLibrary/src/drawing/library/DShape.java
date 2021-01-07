package drawing.library;

import processing.core.PApplet;
import processing.pdf.*;

import java.util.ArrayList;

public class DShape implements DObj{
	ArrayList<DObj> objects;
	public ArrayList<DPoint> vertices;
	public DPoint position;
	private  DColor fillColor;
	private  DColor strokeColor;
	private float strokeWeight;
	private boolean isClosed = false;
	private  boolean noFill;
	private boolean reflectX = false;
	private boolean reflectY = false;
	
	private boolean noStroke;
	private PApplet myParent;
	  
	  DShape(PApplet myParent,DColor fillColor, DColor strokeColor, float strokeWeight,boolean noFill, boolean noStroke){
	   this.myParent = myParent;
	   this.fillColor = fillColor;
	   this.strokeColor = strokeColor;
	   this.noFill = noFill;
	   this.noStroke = noStroke;
	   this.objects = new ArrayList<DObj>();
	   this.strokeWeight = strokeWeight;
	   this.vertices = new ArrayList<DPoint>();
	  
	   this.position = new DPoint(0,0);
	   if(!noStroke){
		   myParent.stroke(strokeColor.r,strokeColor.g,strokeColor.b,strokeColor.a);
	   }
	   else{
		   myParent.noStroke();
	   }
	   if(!noFill){
		   myParent.fill(fillColor.r,fillColor.g,fillColor.b,fillColor.a);

	   }
	   else{
		   myParent.noFill();
	   }
	  }
	  
	  public void reflectX(boolean reflect){
		  this.reflectX = reflect;
	  }
	  
	  public void reflectY(boolean reflect){
		  this.reflectY = reflect;
	  }
	  
	  public void concatMatrix(DShape shape){
		  ArrayList<DObj> transforms = shape.getTransformations();
		  PApplet.print("transformation count ="+transforms.size()+"\n");

		  for(int i=0;i<transforms.size();i++){
			  shape.applyTransform(transforms.get(i));
		  }
	  }
	  
	  public ArrayList<DObj> getTransformations(){
		  ArrayList<DObj> transforms = new ArrayList<DObj>();

		  for(int i=0;i<this.objects.size();i++){
			  if(this.objects.get(i) instanceof DPoint == false){
				  transforms.add(this.objects.get(i));
			  }
		  }
		  return transforms;
	  }
	  
	  public void applyTransform(DObj transform){
		  if(transform instanceof PushTransform){
			 // PApplet.print("push matrix"+"\n");
			  this.pushMatrix();
		  }
		  else if(transform instanceof PopTransform){
			 // PApplet.print("pop matrix"+"\n");

			  this.popMatrix();
		  }
		  else if(transform instanceof Translate){
			 // PApplet.print("translate"+"\n");

			  Translate t = (Translate)transform;
			  this.translate(t.x,t.y);
		  }
		  else if(transform instanceof Scale){
			 // PApplet.print("scale"+"\n");
			  Scale s = (Scale)transform;
			  this.scale(s.x,s.y);
		  }
		  else if(transform instanceof Rotate){
			 // PApplet.print("rotate"+"\n");
			  Rotate r = (Rotate)transform;
			  this.rotate(r.theta);
		  }
	  }
	  public void close(){
		  this.isClosed = true;
	  }
	  public void open(){
		  this.isClosed = false;
	  }
	  
	  public void pushMatrix(){
			PushTransform p = new PushTransform(this.myParent,false);
			objects.add(p);
		}
		
		public void popMatrix(){
			PopTransform p = new PopTransform(this.myParent,false);
			objects.add(p);
		}
		
		public void rotate(float theta){
			Rotate r = new Rotate(this.myParent,theta,false);
			objects.add(r);
		}
		
		public void scale(float x, float y){
			Scale s = new Scale(this.myParent,x,y,false);
			objects.add(s);
		}
		
		public void translate(float x, float y){
			Translate t = new Translate(this.myParent,x,y,false);
			objects.add(t);
		}
		
		public DPoint calculateCentroid(){
			float xSum = 0;
			float ySum = 0;
			for(int i = 0;i<this.vertices.size();i++){
				xSum+= this.vertices.get(i).x;
				ySum+= this.vertices.get(i).y;
				
			}
			
			return new DPoint(xSum/this.vertices.size(),ySum/this.vertices.size());	
		}
		
	public ArrayList<DPoint> getNormalizedVertices(){
		ArrayList<DPoint> nV = new ArrayList<DPoint>();
		DPoint centroid = this.calculateCentroid();
		for(int i = 0;i<this.vertices.size();i++){
			float nX = this.vertices.get(i).x-centroid.x;
			float nY = this.vertices.get(i).y-centroid.y;
			nV.add(new DPoint(nX,nY));
		}
		return nV;
	}
	  
	  public void addVertex(float x,float y){
		 
		  DPoint v = new DPoint(x,y);
		  int lastVertex = this.lastVertex();
		  if(lastVertex > -1){
			  DPoint last = (DPoint)this.objects.get(lastVertex);
			  myParent.fill(fillColor.r,fillColor.g,fillColor.b,fillColor.a);
			  myParent.stroke(strokeColor.r,strokeColor.g,strokeColor.b,strokeColor.a);
			  myParent.strokeWeight(strokeWeight);
			  myParent.pushMatrix();
			  for(int i = 0;i<this.objects.size();i++){
				  this.objects.get(i).renderTransformation(myParent);
			  }
			  myParent.line(last.x,last.y,x,y);
			  myParent.popMatrix();

		  }
		  this.objects.add(v);
		  this.vertices.add(v);
		  this.position = v;
	  }
	  
	  public void addDelta(float x, float y){
		  int lastVertex = this.lastVertex();
		  if(lastVertex > -1){
			  DPoint last = (DPoint)this.objects.get(lastVertex);
			  float nX = last.x+x;
			  float nY = last.y+y;
			  this.addVertex(nX,nY);
		  }
		  else{
			  this.addVertex(0,0);
		  }
	  }
	  
	  public int lastVertex(){
		  for(int i=this.objects.size()-1;i>=0;i--){
			  DObj o = this.objects.get(i);
			  if(o instanceof DPoint){
				  return i;
			  }
		  
		  }
		  return -1;
	  }
	  
	  public void renderTransformation(PApplet parent){
		  if(!noStroke){
			  parent.stroke(strokeColor.r,strokeColor.g,strokeColor.b,strokeColor.a);
		   }
		   else{
			   parent.noStroke();
		   }
		   if(!noFill){
			   parent.fill(fillColor.r,fillColor.g,fillColor.b,fillColor.a);

		   }
		   else{
			   parent.noFill();
		   }
			parent.strokeWeight(strokeWeight);

		   parent.beginShape();
		for(int i=0;i<this.objects.size();i++){
			this.objects.get(i).renderTransformation(parent);
		}
		parent.endShape();
	  }
	  
	  public void drawIntoPDF(PGraphicsPDF pdf){
	    if(!noStroke){
			   pdf.stroke(strokeColor.r,strokeColor.g,strokeColor.b,strokeColor.a);
		   }
		   else{
			   pdf.noStroke();
		   }
		   if(!noFill){
			   pdf.fill(fillColor.r,fillColor.g,fillColor.b,fillColor.a);

		   }

		   else{
			   pdf.noFill();
		   }
		   
		   pdf.strokeWeight(strokeWeight);

		   
		 pdf.pushMatrix();
		pdf.beginShape();
		for(int i=0;i<this.objects.size();i++){
			this.objects.get(i).drawIntoPDF(pdf);
		}
		if(this.isClosed){
		pdf.endShape(PApplet.CLOSE);
		}
		else{
			pdf.endShape();
		}
		pdf.popMatrix();
	  }
}