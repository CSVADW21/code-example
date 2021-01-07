//Hello World Portrait
//created by Jennifer Jacobs September 26 2019. Inspired by Casey Reas' and Ben Fry's draw a face assignment.

//set the size of the canvas to 600 x 600 pixels
size(600,600);

//set the background color to black
background(0,0,0);

//set the rect mode to center. All calls to rect() will now interpret the first two parameters as the shape's center point, while the third and fourth parameters are its width and height.
rectMode(CENTER);

//set the fill to red. Whatever will be drawn after that will have a fill color of red.
fill(255,0,0);
//draw a 300 x 300 rectangle in the center of the canvas
rect(width/2,height/2,300,300);

//set the fill to white
fill(255,255,255);
//draw two white rectangles (the eyes)
rect(width/2-60,height/2-60,100,20);
rect(width/2+60,height/2-60,100,20);

//set the fill to black
fill(0,0,0);
//draw two black rectangles (the pupils)
rect(width/2-60,height/2-60,10,20);
rect(width/2+60,height/2-60,10,20);

//set ellipse mode to center
ellipseMode(CENTER);

//draw an ellipse in the center of the canvas (the mouth)
ellipse(width/2,height/2,200,40);

//set the stroke weight to five pixels. Stroke weight is the thickness of the border around the shapes
strokeWeight(5);
//draw two lines at the edge of the moutn
line(width/2-100,height/2-20,width/2-100,height/2+20);
line(width/2+100,height/2-20,width/2+100,height/2+20);
