package drawing.library;

import processing.core.PApplet;
import processing.pdf.*;


public class DLine implements DObj{
	DPoint start;
	DPoint end;
	private  DColor fillColor;
	private  DColor strokeColor;
	private  boolean noFill;
	private boolean noStroke;
	private PApplet myParent;
	  
	  DLine(PApplet myParent, float x1, float y1,float x2, float y2, DColor fillColor, DColor strokeColor, boolean noFill, boolean noStroke){
	   this.myParent = myParent;
	   this.start = new DPoint(x1,y1);
	   this.end = new DPoint(x2,y2);
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
		   parent.line(this.start.x,this.start.y,this.end.x,this.end.y);
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
	    pdf.line(this.start.x,this.start.y,this.end.x,this.end.y);
	  }
}