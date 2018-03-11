float inc = 0.01;
int scl = 15;
int cols, rows;
float xstart, ystart;
float zoff = 0;
int angleMultiplier;

GridPoint[] flowfield;

void setup() {
  size(900, 900);
  cols = round((width - 300) / scl);
  rows = round((height - 300) / scl);
  
  flowfield = new GridPoint[cols*rows];
  initField();
  
  xstart = random(500);
  ystart = random(500);
  angleMultiplier = floor(random(10));
  //blendMode(ADD);
}

void draw() {
  background(0);
  
  translate(150 + scl/2, 150 + scl/2);
  
  updateField();
  drawField();
  
  
  //saveFrame("frame-#####.png");
  //noLoop();
    
  //saveFrame("screens/line-######.png");
  //if (frameCount >= 680) {
  //  noLoop();
  //}
  //println(frameCount);
}

void updateField() {
  float yoff = ystart;
  for (int y = 0; y < rows; y++) {
    float xoff = xstart;
    for (int x = 0; x < cols; x++) {
      int fieldIndex = x+y*cols;
      //float angle = noise(xoff, yoff, zoff) * TWO_PI * 10;
      //float angle = sin(xoff * x + yoff * y + zoff * fieldIndex);
      //float angle = sin(xoff + yoff + zoff) * fieldIndex/2;
      //float angle = sin((x + y) * zoff);
      float angle = sin((xoff + x) * (yoff + y) * zoff);
      PVector v = new PVector(x, y).rotate(angle);
      //v.setMag(noise(xoff, yoff, zoff)*zoff*20);
      //v.setMag(angle*scl*2);
      v.setMag(scl/2);
      //v.setMag(noise(x, y, scl)*scl);
      
      //flowfield[fieldIndex].angle = v;
      flowfield[fieldIndex].showPos = flowfield[fieldIndex].startPos.copy().add(v);
      //flowfield[fieldIndex].showPos.add(v);
      
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
  
  zoff += 0.01;
}

void drawField() {
  for (int y = 0; y < rows; y++) {
    for (int x = 0; x < cols; x++) {
      int fieldIndex = x+y*cols;
      GridPoint thisPoint = flowfield[fieldIndex];
      //thisPoint.show();

      stroke(255, 150);
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