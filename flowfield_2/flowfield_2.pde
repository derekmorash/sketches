float inc = 0.01;
int scl = 20;
int cols, rows;
float xstart, ystart;
float zoff = 0;
int angleMultiplier;

PVector[] flowfield;
Particle[] particles = new Particle[1000];

void setup() {
  size(800, 800);
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
  
  //noLoop();
  background(0);
  updateField();
}

void draw() {
  blendMode(BLEND);
  background(0);
  
  updateField();
  
  blendMode(ADD);
  for (int i = 0; i < particles.length; i++) {
    particles[i].follow(flowfield);
    particles[i].update();
    particles[i].show();
  }
  
  //if (frameCount % 100 == 0) {
  //  println("reset");
  //  //xstart = random(5000);
  //  //ystart = random(5000);
  //  angleMultiplier = floor(random(10));
  //}
  
  if (frameCount % 10 == 0) {
    saveFrame();
  }
}

void updateField() {
  float yoff = ystart;
  for (int y = 0; y < rows; y++) {
    float xoff = xstart;
    for (int x = 0; x < cols; x++) {
      int fieldIndex = x+y*cols;
      float angle = 0;
      //angle = noise(xoff, yoff, zoff) * TWO_PI * 4;
      //angle = noise(xoff, yoff) * TWO_PI * 4;
      angle = sin(xoff) * cos(yoff) * sin(zoff) * PI * 4;// angleMultiplier * 1;
      //angle = (sin(xoff) + cos(yoff) + sin(zoff)) * PI * angleMultiplier * 0.1;
      //angle = (sin(x * xoff) + sin(y * yoff)) * PI;
      PVector v = PVector.fromAngle(angle);
      v.setMag(0.01);
      flowfield[fieldIndex] = v;
      
      //strokeWeight(1);
      //stroke(255, 250);
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