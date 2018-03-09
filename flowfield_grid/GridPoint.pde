class GridPoint {
  PVector startPos;
  PVector showPos;
  PVector angle = PVector.fromAngle(0);
  //float angle = 0;
  
  GridPoint(PVector newPos) {
    startPos = newPos;
  }
  
  void show() {
    strokeWeight(4);
    stroke(255);
    point(showPos.x, showPos.y);
  }
}