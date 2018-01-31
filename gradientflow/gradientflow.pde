int cellSize = 20;
PImage cell = createImage(cellSize, cellSize, ARGB);
float xoff;
float yoff;

void setup() {
  size(900, 900);
  //noLoop();
  
  int r = abs(floor(255 * random(-1, 1)));
  int g = abs(floor(150 * random(-1, 1)));
  int b = abs(floor(150 * random(-1, 1)));
  
  cell.loadPixels();
  for (int i = 0; i < cell.pixels.length; i++) {
    cell.pixels[i] = color(r, g, b, (i % (cell.width)) * 10);
  }
  cell.updatePixels();
  
  xoff = random(0.0001, 0.0009);
  yoff = random(0.0001, 0.0009);
  
  imageMode(CENTER);
}

void draw() {
  background(255);
  pattern();
  
  if (frameCount < 600) {
    saveFrame();
  }
}

void pattern() {
  for (int x = 0; x < width; x += cellSize) {
    for (int y = 0; y < height; y += cellSize) {
      int noiseVal = floor(map(noise(x * xoff, y * yoff, frameCount*0.008), 0, 1, 0, 4));
      
      pushMatrix();
      translate(x + cellSize/2,y + cellSize/2);
      
      switch(noiseVal) {
        case 0:
          rotate(PI/2);
          break;
        case 3:
          rotate(TAU);
          break;
        case 1:
          rotate(PI);
          break;
        case 2:
          rotate(PI+PI/2);
          break;
      }
      image(cell,0,0);
      popMatrix();
    }
  }
}