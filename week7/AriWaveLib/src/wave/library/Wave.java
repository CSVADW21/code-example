package wave.library;


import processing.core.*;
import processing.sound.SinOsc;
 


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

public class Wave {
	
	// myParent is a reference to the parent sketch
	PApplet myParent;
	SinOsc sine;
	String type = "";
	PVector location = new PVector(0,0); 
	float[] yvalues;
	float amplitude, period, dx;
	float theta = (float) 0.0;
	float rotation = (float) 0.0;
	int resolution = 10;
	int width, r, g, b;
	int stroke_weight = 10;
	boolean sound = false;
	
	
	public final static String VERSION = "1.0.0";
	

	/**
	 * a Constructor, usually called in the setup() method in your sketch to
	 * initialize and start the Library.
	 * 
	 * @example Hello
	 * @param theParent
	 * @param theSine
	 */
	public Wave(PApplet theParent) {
		myParent = theParent;
		sine = new SinOsc(theParent);
	}
	
	public void setWave(float _amplitude, float _period, int _width) {
		amplitude = _amplitude;
		period = _period;
		width = _width;
	}
	
	public void drawWave() {
			yvalues = new float[width/resolution];
			dx = (PApplet.TWO_PI / period) * resolution;
			theta += 0.02;
			
			float x = theta;
			for(int i = 0; i < yvalues.length; i++) {
				yvalues[i] = PApplet.sin(x)*amplitude;
				x+=dx;
			}
			renderWave();
	}
	
	private void renderWave() {
	    PShape shape;
	    myParent.noFill();
	    shape = myParent.createShape();
	    if(type.equals("")) {
	    	shape.beginShape();
	    }
	  //POINTS, LINES, TRIANGLES, TRIANGLE_STRIP, QUADS, and QUAD_STRIP.
	    else if(type.equals("points")) {
	    	shape.beginShape(PShape.POINTS);
	    }
	    else if(type.equals("lines")) {
	    	shape.beginShape(PShape.LINES);
	    }
	    else if(type.equals("triangles")) {
	    	shape.beginShape(PShape.TRIANGLES);
	    }
	    else if(type.equals("triangle_strip")) {
	    	shape.beginShape(PShape.TRIANGLE_STRIP);
	    }
	    else if(type.equals("quads")) {
	    	shape.beginShape(PShape.QUADS);
	    }
	    else if(type.equals("quad_strip")) {
	    	shape.beginShape(PShape.QUAD_STRIP);
	    }
	    shape.rotate(PApplet.radians(rotation));
	    shape.translate(location.x, location.y);
	    shape.strokeWeight(stroke_weight);
	    shape.stroke(myParent.color(r,g,b));
	    for (int x = 0; x < yvalues.length; x++) {
	    	shape.vertex(x*resolution, yvalues[x]);
	    	if(sound) {
	    		sine.amp(yvalues[x]/amplitude);
	            sine.freq(x*resolution);
	    	}
	    }
	    myParent.pushMatrix();
	    shape.endShape();
	    myParent.shape(shape);
	    myParent.popMatrix();
	}
	
	public void resolution(int _resolution) {
		resolution = _resolution;
	}
	
	public void rotate(int _rotation) {
		rotation = _rotation;
	}
	
	public void translate(PVector _location) {
		location = _location;
	}
	
	public void stroke(int _r, int _g, int _b) {
		r = _r;
		g = _g;
		b = _b;
	}
	public void strokeWeight(int _stroke_weight) {
		stroke_weight = _stroke_weight;
	}
	public void type(String _type) {
		type = _type.toLowerCase();
	}
	public void sound() {
		sound = true;
		sine.play();
	}
	public void blur(int r_, int g_, int b_) {
	    myParent.noStroke();
	    myParent.fill(r_,g_,b_, 20);
	    myParent.rect(0, 0, myParent.width, myParent.height);		
	}
}
	
	
	
	
	
	
