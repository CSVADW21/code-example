package sample.library;


import processing.core.*;
import controlP5.*;
import sample.library.MyListener;
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


public class HelloLibrary {
	
	// myParent is a reference to the parent sketch
	PApplet myParent;

	int myVariable = 0;
	
	public final static String VERSION = "##library.prettyVersion##";
	public ControlP5 cp5;
	public Controller numPalettes;
	public int paletteNum;
	public MyListener myListener;


	/**
	 * a Constructor, usually called in the setup() method in your sketch to
	 * initialize and start the Library.
	 * 
	 * @example Hello
	 * @param theParent the parent PApplet
	 */
	public HelloLibrary(PApplet theParent) {
		myParent = theParent;
		welcome();
		cp5 = new ControlP5(myParent);
		
		
	}
	
	public void setupCP5() {
		myListener = new MyListener();
		numPalettes = cp5.addSlider("paletteNum").setPosition(625, 24).setRange(1, 64);
		cp5.getController("paletteNum").addListener(myListener);	
	}
	
	private void welcome() {
		System.out.println("##library.name## ##library.prettyVersion## by ##author##");
	}
	
	
	public String sayHello() {
		return "hello library.";
	}
	/**
	 * return the version of the Library.
	 * 
	 * @return String
	 */
	public static String version() {
		return VERSION;
	}

	/**
	 * 
	 * @param theA the width of test
	 * @param theB the height of test
	 */
	public void setVariable(int theA, int theB) {
		myVariable = theA + theB;
	}

	/**
	 * 
	 * @return int
	 */
	public int getVariable() {
		return myVariable;
	}
	
}
