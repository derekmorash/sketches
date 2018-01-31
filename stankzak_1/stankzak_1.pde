boolean isblack = true;

color white = color(255);
color black = color(0);

void setup() {
  size(900,900);
  //noLoop();
}

void draw() {
  isblack = true;
  //background(255, 0, 0);
  
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      float noiseval = noise(x*0.0003, y*0.005, frameCount*0.003);
      color setcol = black;
      
      if (noiseval > 0.4) {
        setcol = isblack ? black : white;
      } else {
        setcol = isblack ? white : black;
      }
      
      pixels[x + y*width] = setcol;
    }
    
    if (x > 0 && x%4 == 0) {
      isblack = !isblack;
    }
  }
  updatePixels();
}