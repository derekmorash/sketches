float xScale = random(0.01, 0.1);
float yScale = random(0.01, 0.1);
color purple = color(87, 84, 161);
color red = color(224, 56, 45);

void setup() {
  size(600,300);
}

void draw() {
 
  loadPixels();
  for(int x = 0; x < width; x++) {
    for(int y = 0; y < height; y++) {
      boolean noiseVal = noise(xScale*x, yScale*y, frameCount*0.001)>0.5;
      color noiseColor = noiseVal?purple:red;
      pixels[x + width*y] = noiseColor;
    }
  }
  updatePixels();
  //noLoop();
}