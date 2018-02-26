import java.util.ArrayList;

ArrayList<PVector> vertices = new ArrayList<PVector>();
int line_posY = 3;

void setup() {
  size(1200, 1200);
  blendMode(BLEND);
  noFill();
  stroke(0, 80);
  strokeWeight(1);
  init();
}

void mousePressed() {
  init();
  loop();
}

void init() {
  vertices.clear();

  for (int i = 20; i <= width-20; i += random(25, 35)) {
    vertices.add(new PVector(i, 40));
  }
}


void resetSpline() {
  for (int i = 0; i < vertices.size(); i++) {
    PVector newPos = vertices.get(i);
    newPos.y += line_posY;
    vertices.set(i, newPos);
  }
}

void draw() {
  noLoop();
  background(255);
  int loop_index = 0;

  while (vertices.get(0).y <= height - 40) {
    beginShape();
    for (int i = 0; i < vertices.size(); i++) {
      float rangeX = i * 0.05 + loop_index * 0.0001;
      float rangeY = i * 0.1 + loop_index * 0.001;
      float offsetX = map(round(random(-1, 1)), -1, 1, -rangeX, rangeX);
      float offsetY = map(round(random(-1, 1)), -1, 1, -rangeY, rangeY);
      
      PVector newPos = vertices.get(i);
      newPos.x += offsetX;
      newPos.y += offsetY;
      vertices.set(i, newPos);

      curveVertex(newPos.x, newPos.y);
    }
    endShape();

    loop_index++;
    resetSpline();
  }
  
  saveFrame();
}