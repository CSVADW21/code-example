package drawing.library;

import processing.core.PApplet;
import processing.pdf.*;


public class PopTransform implements DObj {
	
	PopTransform(PApplet myParent){
		this.renderTransformation(myParent);
	}
	
	PopTransform(PApplet myParent, boolean apply){
		if(apply){
			this.renderTransformation(myParent);
		}
		
	}
	public void renderTransformation(PApplet parent){
		parent.popMatrix();

	}
	public void drawIntoPDF(PGraphicsPDF pdf){
	   pdf.popMatrix();
	  }
}



