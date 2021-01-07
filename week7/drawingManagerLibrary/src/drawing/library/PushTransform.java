package drawing.library;

import processing.core.PApplet;
import processing.pdf.*;


public class PushTransform implements DObj {
	
	PushTransform(PApplet myParent){
		this.renderTransformation(myParent);
	}
	
	PushTransform(PApplet myParent, boolean apply){
		if(apply){
			this.renderTransformation(myParent);

		}
		
	}
	public void renderTransformation(PApplet parent){
		parent.pushMatrix();

	}
	
	public void drawIntoPDF(PGraphicsPDF pdf){
	   pdf.pushMatrix();
	  }
}



