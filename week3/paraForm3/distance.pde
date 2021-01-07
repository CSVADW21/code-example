
float euclidDistance(float[] a, float[] b) {
    float total = 0, diff;
    
    for (int i = 0; i < a.length; i++) {
        diff = b[i] - a[i];
        total += diff * diff;
    }
    return (float)Math.sqrt(total);
}


float[] getBaseVector(){
  return new float[]{resolution,frequency,amplitude,vaseHeight,phase}; 
}

 
