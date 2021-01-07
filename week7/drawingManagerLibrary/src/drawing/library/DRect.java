package drawing.library;

import processing.core.PApplet;
import processing.pdf.*;


public class DRect implements DObj{
	  DPoint origin;
	  float width;
	  float height;
	  private  DColor fillColor;
		private  DColor strokeColor;
		private  boolean noFill;
		private boolean noStroke;
		private PApplet myParent;
	  
	  DRect(PApplet myParent, float x, float y,float width, float height, DColor fillColor, DColor strokeColor, boolean noFill, boolean noStroke){
	   this.myParent = myParent;
	   this.origin = new DPoint(x,y);
	   this.width = width;
	   this.height = height;
	   this.fillColor = fillColor;
	   this.strokeColor = strokeColor;
	   this.noFill = noFill;
	   this.noStroke = noStroke;
	   this.renderTransformation(myParent);

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
	    pdf.rect(origin.x,origin.y,width,height);
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
			   parent.rect(origin.x,origin.y,width,height);
		  }
}