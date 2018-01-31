int smallGrid = 4;
float smallProb;
int bigGrid = 10;
float bigProb;

int bgr;
int bgg;
int bgb;

int canvasWidth = 500;
int canvasHeight = 700;

void setup() {
  size(1600, 900);
  //noLoop();
  
  smallProb = random(0.3,0.7);
  bigProb = random(0.3,0.7);

  bgr = floor(random(50, 70));
  bgg = floor(random(44, 64));
  bgb = floor(random(60, 80));
}

void draw() {
  //background(bgr, bgg, bgb);
  background(255);
  noStroke();
  fill(bgr, bgg, bgb);
  translate(width/2-canvasWidth/2, height/2-canvasHeight/2);
  rect(0,0,canvasWidth,canvasHeight);
  drawGrid(bigGrid, color(bgr+10, bgg+5, bgb+15), smallProb);
  drawGrid(smallGrid, color(255), bigProb);
}

void drawGrid(int gridSize, color dotColour, float noiseProb) {
  //resetMatrix();
  noStroke();
  fill(dotColour);
  pushMatrix();
  translate(gridSize/2, gridSize/2);
  for (int x = 0; x < canvasWidth; x+= gridSize*2) {
    for (int y = 0; y < canvasHeight; y+= gridSize*2) {
      float noiseVal = noise(x * 0.01 + gridSize, y * 0.01 + gridSize, frameCount * 0.01 + gridSize);
      
      if (noiseVal > noiseProb) {
        ellipse(x,y, gridSize, gridSize);
      }
    }
  }
  popMatrix();
}