class ColorNode {
  float radius;
  float hue, sat, bri;
  color c;
  PVector pos;
  
  ArrayList<GradientEdgeRect> edges;
  
  ColorNode(int x, int y, float r, color c) {
    pos = new PVector(x, y);
    radius = r;
    this.c = c;
    
    colorMode(HSB, 255);
    hue = hue(c);
    sat = saturation(c);
    bri = brightness(c);
    
    edges = new ArrayList<GradientEdgeRect>();
  }
  
  void draw() {
    colorMode(HSB, 255);
    fill(hue, sat, bri);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
  }
  
  boolean hitTest(int x, int y) {
    if(pow(x - pos.x, 2) + pow(y - pos.y, 2) < pow(radius, 2)) {
      return true;
    }
    
    return false;
  }
  
  void move(PVector d) {
    pos.add(d);
    
    updateEdges();
  }
  
  void changeHue(int x, int y) {
    PVector v1 = new PVector(x, y);
    int d = (int)map(pos.dist(v1), 0, radius, 0, 255);
    
    hue = d;
    
    colorMode(HSB, 255);
    c = color(hue, sat, bri);
    
    updateEdgesColor();
  }
  
  void changeBright(int x, int y) {
    PVector v1 = new PVector(x, y);
    int d = (int)map(pos.dist(v1), 0, radius, 0, 255);
    
    bri = d;
    
    colorMode(HSB, 255);
    c = color(hue, sat, bri);
    
    updateEdgesColor();
  }
  
  void changeSaturation(int x, int y) {
    PVector v1 = new PVector(x, y);
    int d = (int)map(pos.dist(v1), 0, radius, 0, 255);
    
    sat = d;
    
    colorMode(HSB, 255);
    c = color(hue, sat, bri);
    
    updateEdgesColor();
  }
  
  void changeRadius(int x, int y) {
    PVector v1 = new PVector(x, y);
    radius = pos.dist(v1);
    
    updateEdges();
  }
  
  void updateEdgesColor() {
    for(GradientEdgeRect edge : edges) {
      if(edge.startNode == this) 
        edge.setStartColor(this.c); 
      else if(edge.endNode == this)
        edge.setEndColor(this.c);
    };
  }
  
  void updateEdges() {
    for(GradientEdgeRect edge : edges) {
      if(edge.startNode == this || edge.endNode == this)
        edge.cacluateRect();
    };
  }
  
  void addEdge(GradientEdgeRect edge) {
    edges.add(edge);
  }
  
  void removeEdge(GradientEdgeRect edge) {
    int index = edges.indexOf(edge);
    if(index >= 0) edges.remove(index);
  }
  
  boolean hasEdgeWith(ColorNode node) {
    for(GradientEdgeRect edge : edges) {
      if(edge.endNode == node || edge.startNode == node) return true;
    }
    return false;
  }
  
  void removeAllEdges() {
    edges.clear();
  }
}
