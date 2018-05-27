PVector[] vertices;
float vertexAmt = 0.0005;

void setup() {
  size(400, 400);
  vertices = new PVector[floor(PI/vertexAmt)];
  println(vertices.length);
  noStroke();
  //noLoop();
}

void draw() {
  background(255);
  translate(width/2, height/2);
  
  for (int i = 50; i < width-10; i+=20) {
    drawCircle(i);
  }
  
  //saveFrame("frame-#####.png");
}

void drawCircle(int radius) {
  makeCircle(radius);
  
  for (int i = 0; i < vertices.length; i++) {
    float thiccness = sin(map(i, 0, vertices.length-1, 0, TAU)) * (radius*0.1/10);
    fill(50);
    ellipse(vertices[i].x, vertices[i].y, thiccness, thiccness);
  }
}

void makeCircle(int radius) {
  for (int i = 0; i < vertices.length; i++) {
    float x = radius * sin(map(i, 0, vertices.length-1, 0, TAU));
    float y = radius * cos(map(i, 0, vertices.length-1, 0, TAU));
    vertices[i] = new PVector(x, y);
    //vertices[i] = new PVector(radius * sin(i/vertexAmt), radius * cos(i/vertexAmt));
  }
}
