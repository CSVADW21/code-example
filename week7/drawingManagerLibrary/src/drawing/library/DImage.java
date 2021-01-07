package drawing.library;

import processing.core.PApplet;
import processing.pdf.*;
import processing.core.PImage;



public class DImage implements DObj{
	  DPoint origin;
	  float width;
	  float height;
	  PImage name;
	  private PApplet myParent;
	  
	  DImage(PApplet myParent, PImage name, float x, float y,float width, float height){
	   this.myParent = myParent;
	   this.origin = new DPoint(x,y);
	   this.width = width;
	   this.height = height;
	  this.name = name;
	   this.renderTransformation(myParent);

	  }
	  
	  public void drawIntoPDF(PGraphicsPDF pdf){
	    pdf.image(name,origin.x,origin.y,width,height);
	  }
	  
	  public void renderTransformation(PApplet parent){   
		 parent.image(name,origin.x,origin.y,width,height);
	  }
}