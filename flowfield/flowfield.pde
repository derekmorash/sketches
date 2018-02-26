float inc = 0.01;
int scl = 20;
int cols, rows;
float xstart, ystart;
float zoff = 0;
int angleMultiplier;

PVector[] flowfield;
Particle[] particles = new Particle[1000];

void setup() {
  size(400, 400);
  cols = round(width / scl);
  rows = round(height / scl);
  
  flowfield = new PVector[cols*rows];
  
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(new PVector(random(width), random(height)));
    //particles[i] = new Particle(new PVector(width/2, height/2));
  }
  
  xstart = random(500);
  ystart = random(500);
  angleMultiplier = floor(random(10));
  
  //updateField();
}

void draw() {
  background(0);
  
  updateField();
  
  for (int i = 0; i < particles.length; i++) {
    particles[i].follow(flowfield);
    particles[i].update();
    particles[i].show();
  }
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
      flowfield[fieldIndex] = v;
      
      strokeWeight(1);
      stroke(255, 50);
      pushMatrix();
      translate(x*scl, y*scl);
      rotate(v.heading());
      line(0, 0, scl, 0);
      popMatrix();
      
      xoff += 0.1;
    }
    yoff += 0.1;
  }
  
  zoff += 0.004;
}