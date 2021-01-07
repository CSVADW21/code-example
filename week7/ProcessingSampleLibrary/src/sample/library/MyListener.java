package sample.library;
import controlP5.*;

public class MyListener implements ControlListener {
	  public void controlEvent(ControlEvent theEvent) {
	    System.out.println("i got an event from mySlider, " +
	            "changing to "+
	            theEvent.getController().getValue());
	  
	  }

	}