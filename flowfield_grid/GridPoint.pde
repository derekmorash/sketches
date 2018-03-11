class GridPoint {
  PVector startPos;
  PVector showPos;
  PVector angle = PVector.fromAngle(0);
  //float angle = 0;
  
  GridPoint(PVector newPos) {
    startPos = newPos;
    showPos = newPos;
  }
  
  void show() {
    strokeWeight(2);
    stroke(255);
    point(showPos.x, showPos.y);
    
    //blendMode(ADD);
    //stroke(255, 0, 0, 150);
    //point(showPos.x, showPos.y);
    
    //stroke(0, 255, 0, 150);
    //point(showPos.x-1, showPos.y-1);
    
    //stroke(0, 0, 255, 150);
    //point(showPos.x+1, showPos.y+1);
  }
}