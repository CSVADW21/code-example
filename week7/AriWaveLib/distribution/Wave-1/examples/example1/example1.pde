import wave.library.*;

Wave w;
ArrayList<Wave> w_array;
int waves = 10;
void setup() {
  size(600, 600, P2D);
  w_array = new ArrayList<Wave>();
  for(int i =0; i < waves; i++){ 
    w = new Wave(this);
    w.setWave(75, random(100,500), width+30);
    w.translate(new PVector(0, random(50,height-50)));
    w.resolution(int(random(10,100)));
    w.strokeWeight(1);
    w_array.add(w);
  }
}
void draw() {
  w.blur(0,0,0);
  for(Wave w: w_array){
    w.stroke(0,int(random(255)),int(random(255)));
    w.drawWave();
  }
}