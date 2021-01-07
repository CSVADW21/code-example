package drawing.library;

import processing.core.PApplet;
import processing.pdf.*;


public class DTriangle implements DObj{
	DPoint p1;
	DPoint p2;
	DPoint p3;
	
	private  DColor fillColor;
	private  DColor strokeColor;
	private  boolean noFill;
	private boolean noStroke;
	private PApplet myParent;
	  
	  DTriangle(PApplet myParent, float x1, float y1,float x2, float y2,float x3, float y3, DColor fillColor, DColor strokeColor, boolean noFill, boolean noStroke){
	   this.myParent = myParent;
	   this.p1 = new DPoint(x1,y1);
	   this.p2 = new DPoint(x2,y2);
	   this.p3 = new DPoint(x3,y3);

	   this.fillColor = fillColor;
	   this.strokeColor = strokeColor;
	   this.noFill = noFill;
	   this.noStroke = noStroke;
	   this.renderTransformation(myParent);
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
			   parent.triangle(this.p1.x,this.p1.y,this.p2.x,this.p2.y,this.p3.x,this.p3.y);
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
	    pdf.triangle(this.p1.x,this.p1.y,this.p2.x,this.p2.y,this.p3.x,this.p3.y);
	  }
	  
	 
}