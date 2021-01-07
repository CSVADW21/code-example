

import processing.pdf.*;

size(792,612);

beginRecord(PDF, "plot.pdf"); 
noFill();
//write code for whatever geometry you want to plot here.
for(int i=0;i<100;i++){
  float theta = 2*PI/100*i;
  println(degrees(theta));
  float x = sin(theta)*width/2.25;
  float y = cos(theta)*height/2.25;
  ellipse(x+width/2,y+height/2,40,40);
}

endRecord();
