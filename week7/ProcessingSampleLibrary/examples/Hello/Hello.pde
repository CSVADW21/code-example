import sample.library.*;
import controlP5.*;

HelloLibrary hello;

void setup() {
  size(1000,1000);
  smooth();
  hello = new HelloLibrary(this);
    hello.setupCP5();

  
}

void draw() {
  background(0);
  fill(255);
  text(hello.sayHello(), 40, 200);
}
