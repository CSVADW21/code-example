package drawing.library;

import processing.core.PApplet;
import processing.pdf.*;


public class Scale implements DObj {
	public float x;
	public float y;
	
	Scale(PApplet myParent, float x, float y){
		this.x = x;
		this.y = y;
		this.renderTransformation(myParent);
		
	}
	Scale(PApplet myParent, float x, float y, boolean apply){
		this.x = x;
		this.y = y;
	
		if(apply){
			this.renderTransformation(myParent);
		}
	}
	
	public void renderTransformation(PApplet parent){
		parent.scale(this.x,this.y);

	}
	
	public void drawIntoPDF(PGraphicsPDF pdf){
	   pdf.scale(this.x,this.y);
	  }
}




