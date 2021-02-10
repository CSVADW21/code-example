// Palette from Photo Example from Code as Creative Medium

import java.util.Arrays; // lets us use the Java's Arrays.sort method

PImage photo;
color[] palette = new color[5]; // the top 5 most frequent colors in the image get stored here
ArrayList<Color> imageColors = new ArrayList<Color>(); // growing data structure to store all the colors and frequencies in the image

void setup() {
  size(500, 500); 
  photo = loadImage("image.jpg");
  background(255);
  noStroke();
  colorMode(HSB);
  photo.resize(100, 100);
  photo.loadPixels();
  
  readColorFromImage(); // read in the unique color values and update frequency
  sort(); // sort based on frequency
  
  //draw the photo
  photo = loadImage("image.jpg"); // get the original quality back
  photo.resize(3*width/4, height);
  image(photo, 0, 0);
  
  //draw the palette
  for (int i = 0; i < 5; i++) {
    fill(palette[i]); 
    rect(12.5 + 3 * width/4, i * height/5, 100, 100);
  }
}

void readColorFromImage() {
  for (int i = 0; i < photo.width; i++) {
    for (int j = 0; j < photo.height; j++) {
      color c = photo.get(i, j); // get the color value at each pixel (i, j) in the image
      //print(hue(c) + " " + saturation(c) + " " + brightness(c));
      boolean found = false; int index = 0;
      if (imageColors.size() == 0) { imageColors.add(new Color(hue(c), saturation(c), brightness(c))); }
      else {
        for (int a = 0; a < imageColors.size(); a++) {
          if (imageColors.get(a).hue == hue(c)){ // if the hue is in our array -> makes the algorithm quite nice
            found = true; index = a; // trigger a boolean and store the index
            break;
          }
        }
        if (found) { imageColors.get(index).frequency = imageColors.get(index).frequency + 1; } // increment frequency if we already have that color stored
        else { imageColors.add(new Color(hue(c), saturation(c), brightness(c))); } // otherwise, add the color to our arraylist
      }
    }
  }
  println(" ");
}

void sort() {
  int[] freqs = new int[imageColors.size()]; // copy only the frequency values to store
  for (int i = 0; i < imageColors.size(); i++) { // copy the frequencies in
    //read in the frequency vals
    freqs[i] = imageColors.get(i).frequency;
  }
  Arrays.sort(freqs); // sort using Java's Arrays.sort method
  //get the top 5 reoccurring colors only
  for (int i = 0; i < 5; i++) {
    boolean found = false; int index = 0;
    for (int j = 0; j < imageColors.size(); j++) {
       if (imageColors.get(j).frequency == freqs[freqs.length - (i + 1)]) {
         //println("found " + imageColors.get(j).frequency + " " + freqs[freqs.length - (i + 1)]);
         found = true; index = j;
         break;
       }
     }
     if (found)  { palette[i] = color(imageColors.get(index).hue, 
                                      imageColors.get(index).saturation, 
                                      imageColors.get(index).brightness); } // store the color into our main palette
  }
  
  
  for (int i = 0; i < palette.length; i++) {
    println(hue(palette[i]) + " " + saturation(palette[i]) + " " + brightness(palette[i]));
  }
}
