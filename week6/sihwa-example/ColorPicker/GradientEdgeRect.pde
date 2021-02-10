class GradientEdgeRect implements Comparable<GradientEdgeRect> {
  
  PVector startLeft, startMid, startRight;
  PVector endLeft, endMid, endRight;
  color startColor;
  color endColor;
  ColorNode startNode, endNode;
  boolean selected = false;
  
  int zIndex = -1;
  
  public int compareTo(GradientEdgeRect edge) {
    return this.zIndex - edge.zIndex;
  }
  
  public GradientEdgeRect(PVector sl, PVector sr, PVector el, PVector er, color s, color e) {
    startLeft = sl;
    endLeft = el;
    startRight = sr;
    endRight = er;
    
    startColor = s;
    endColor = e;
  }
  
  public GradientEdgeRect(ColorNode s, ColorNode e, int x, int y, int index) {
    startNode = s;
    endNode = (e == null)? s : e;
    startMid = s.pos;
    if(e == null) endMid = new PVector(x, y);
    else endMid = e.pos;
    
    startColor = startNode.c;
    endColor = endNode.c;
    
    this.zIndex = index;
    cacluateRect();
  }
  
  void cacluateRect() {
    PVector v = PVector.sub(endMid, startMid);
    
    float angle = v.heading();
    
    PVector sl = new PVector(startNode.radius, 0);
    sl.rotate(angle + PI * 0.5);
    sl.add(startMid);
    
    PVector el = new PVector(endNode.radius, 0);
    el.rotate(angle + PI * 0.5);
    el.add(endMid);
    
    PVector sr = new PVector(startNode.radius, 0);
    sr.rotate(angle - PI * 0.5);
    sr.add(startMid);
    
    PVector er = new PVector(endNode.radius, 0);
    er.rotate(angle - PI * 0.5);
    er.add(endMid);
    
    startLeft = sl;
    startRight = sr;
    endLeft = el;
    endRight = er;
  }
  
  void draw() {
    noStroke();
    colorMode(HSB, 255);
    beginShape(QUADS);
    fill(startColor);
    vertex(startLeft.x, startLeft.y, 0);
    vertex(startRight.x, startRight.y, 0);
    
    fill(endColor);
    vertex(endRight.x, endRight.y, 0);
    vertex(endLeft.x, endLeft.y, 0);
    
    endShape();
    
  }
  
  void isSelected(boolean s) {
    selected = s;
    
    if(selected) this.zIndex = gZIndex++;
  }
 
  boolean hitTest(int x, int y) {
    PVector p = new PVector(x, y);
    return (isInRect(startLeft, startRight, endRight, endLeft, p));     
  }
  
  void setStartColor(color c) {
    startColor = c;
  }
  
  void setEndColor(color c) {
    endColor = c;
  }
  
  void setEndMid(int x, int y) {
    endMid.x = x;
    endMid.y = y;
    
    cacluateRect();
  }
  
  void setEndNode(ColorNode node) {
    endNode = node;
    endColor = endNode.c;
    
    endMid = endNode.pos;
    
    cacluateRect();
  }
}

// Cheking if a point is inside a rectangle
// based on: https://martin-thoma.com/how-to-check-if-a-point-is-inside-a-rectangle/
float triangleSize(PVector p1, PVector p2, PVector p3) {
  return 0.5 * Math.abs(p1.x * (p2.y - p3.y) + p2.x * (p3.y - p1.y) + p3.x * (p1.y - p2.y));
}

boolean isInRect(PVector a, PVector b, PVector c, PVector d, PVector p) {
  float areaRect = floor(0.5 * Math.abs((a.y - c.y) * (d.x - b.x) + (b.y - d.y) * (a.x - c.x)));
  
  float abp = triangleSize(a, b, p);
  float bcp = triangleSize(b, c, p);
  float cdp = triangleSize(c, d, p);
  float dap = triangleSize(d, a, p);
  
  return areaRect == floor(abp + bcp + cdp + dap);
}
