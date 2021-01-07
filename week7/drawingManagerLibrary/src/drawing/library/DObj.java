package drawing.library;

import processing.core.PApplet;
import processing.pdf.*;


public interface DObj {
	
	 public void drawIntoPDF(PGraphicsPDF pdf);
	  
	 public void renderTransformation(PApplet parent);
}
