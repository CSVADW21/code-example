package drawing.library;


import processing.core.*;
import processing.core.PImage;
import processing.pdf.*;

import java.util.ArrayList;
import java.time.LocalDate;
import java.time.LocalDateTime;
/**
 * This is a template class and can be used to start a new processing Library.
 * Make sure you rename this class as well as the name of the example package 'template' 
 * to your own Library naming convention.
 * 
 * (the tag example followed by the name of an example included in folder 'examples' will
 * automatically include the example in the javadoc.)
 *
 * @example Hello 
 */

public class DrawingManager {
	
	// myParent is a reference to the parent sketch
	PApplet myParent;
	ArrayList<DObj> objects;
	DColor fillColor;
	DColor strokeColor;
	float strokeWeight;
	boolean noFill = true;
	boolean noStroke = false;
	
	
	public final static String VERSION = "##library.prettyVersion##";
	

	/**
	 * constructor
	 *
	 */
	public DrawingManager(PApplet theParent) {
		myParent = theParent;
		objects = new ArrayList<DObj>();
		strokeColor = new DColor(0,0,0);
		fillColor = new DColor(255,255,255);
		strokeWeight = 1;
	}
	
	
	public void fill(int r, int g, int b){
	      fillColor = new DColor(r,g,b);
	      noFill = false;
	    }
	
	public void fill(int r, int g, int b, int a){
	      fillColor = new DColor(r,g,b,a);
	      noFill = false;
	    }
	
	public void stroke(int r, int g, int b){
	      strokeColor = new DColor(r,g,b);
	      noStroke = false;
	    }
	public void stroke(int r, int g, int b, int a){
	      strokeColor = new DColor(r,g,b,a);
	      noStroke = false;
	    }
	
	public void noStroke(){
	     noStroke = true;
	    }
	
	public void strokeWeight(float weight){
	    this.strokeWeight = weight;
	    }
	
	
	public void noFill(){
	     noFill = true;
	    }
	
	
	
	public void line(float x1, float y1,float x2, float y2){
	      DLine l = new DLine(this.myParent, x1, y1,x2,  y2, fillColor,strokeColor,noFill,noStroke);
	      objects.add(l);
	   }
	
	public DShape addShape(){
		DShape dShape = new DShape(this.myParent,fillColor,strokeColor,strokeWeight,noFill,noStroke);
		this.objects.add(dShape);
		return dShape;
	}
	
	public void triangle(float x1, float y1,float x2, float y2,float x3, float y3){
	      DTriangle t = new DTriangle(this.myParent, x1, y1,x2,  y2,x3,y3, fillColor,strokeColor,noFill,noStroke);
	      objects.add(t);
	   }
	
	public void ellipse(float x, float y,float width, float height){
	      DEllipse e = new DEllipse(this.myParent, x, y, width, height, fillColor,strokeColor,noFill,noStroke);
	      objects.add(e);
	   }
	
	public void image(PImage name, float x, float y,float width, float height){
	      DImage i = new DImage(this.myParent,name, x, y, width, height);
	      objects.add(i);
	   }
	
	public void rect(float x, float y,float width, float height){
	     DRect r = new DRect(this.myParent, x, y, width, height, fillColor,strokeColor,noFill,noStroke);
	      objects.add(r);
	   }
	public void pushMatrix(){
		PushTransform p = new PushTransform(this.myParent);
		objects.add(p);
	}
	
	public void popMatrix(){
		PopTransform p = new PopTransform(this.myParent);
		objects.add(p);
	}
	
	public void rotate(float theta){
		Rotate r = new Rotate(this.myParent,theta);
		objects.add(r);
	}
	
	public void scale(float x, float y){
		Scale s = new Scale(this.myParent,x,y);
		objects.add(s);
	}
	
	public void translate(float x, float y){
		Translate t = new Translate(this.myParent,x,y);
		objects.add(t);
	}
	
	public void clear(){
		objects.clear();
		myParent.background(255); 
	}
	    
	    
	public void savePDF(){
		LocalDateTime today = LocalDateTime.now();
		int year = today.getYear();
		int month = today.getMonthValue();
		int day = today.getDayOfMonth();
		int hour = today.getHour();
		int min = today.getMinute();
		int sec = today.getSecond();
		int milsec = today.getNano()/1000000;
	    PGraphicsPDF pdf = (PGraphicsPDF)myParent.beginRaw(PGraphics.PDF, "saved_"+year+"-"+month+"-"+day+"-"+hour+"-"+min+"-"+sec+"-"+milsec+".pdf");
	     
	      for(int i =0;i< objects.size();i++){ 
	        objects.get(i).drawIntoPDF(pdf);
	      }
	     myParent.endRaw();    
	   }
	
	
	/**
	 * return the version of the Library.
	 * 
	 * @return String
	 */
	public static String version() {
		return VERSION;
	}

}

