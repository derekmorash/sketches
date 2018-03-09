float inc = 0.01;
int scl = 20;
int cols, rows;
float xstart, ystart;
float zoff = 0;
int angleMultiplier;

GridPoint[] flowfield;

void setup() {
  size(400, 400);
  cols = round(width / scl);
  rows = round(height / scl);
  
  flowfield = new GridPoint[cols*rows];
  initField();
  
  xstart = random(500);
  ystart = random(500);
  angleMultiplier = floor(random(10));
  
  //updateField();
}

void draw() {
  background(0);
  
  updateField();
  drawField();
}

void updateField() {
  float yoff = ystart;
  for (int y = 0; y < rows; y++) {
    float xoff = xstart;
    for (int x = 0; x < cols; x++) {
      int fieldIndex = x+y*cols;
      float angle = noise(xoff, yoff, zoff) * TWO_PI * 2;
      PVector v = PVector.fromAngle(angle);
      v.setMag(0.1);
      flowfield[fieldIndex].angle = v;
      flowfield[fieldIndex].showPos = flowfield[fieldIndex].startPos.copy().rotate(v.heading()).add(scl, 0);
      
      //strokeWeight(1);
      //stroke(255);
      //pushMatrix();
      //translate(x*scl, y*scl);
      //rotate(v.heading());
      //line(0, 0, scl, 0);
      //popMatrix();
      
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  
  zoff += 0.004;
}

void drawField() {
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      int fieldIndex = x+y*cols;
      GridPoint thisPoint = flowfield[fieldIndex];
      thisPoint.show();

      stroke(255, 250);
      strokeWeight(1);
      if (x < cols-1) {
        GridPoint nextXPoint = flowfield[(x+1)+y*cols];
        line(thisPoint.showPos.x, thisPoint.showPos.y, nextXPoint.showPos.x, nextXPoint.showPos.y);
      }
      if (y < rows-1) {
        GridPoint nextYPoint = flowfield[x+(y+1)*cols];
        line(thisPoint.showPos.x, thisPoint.showPos.y, nextYPoint.showPos.x, nextYPoint.showPos.y);
      }
    }
  }
}

void initField() {
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      int fieldIndex = x+y*cols;
      flowfield[fieldIndex] = new GridPoint(new PVector(x*scl,y*scl));
    }
  }
}