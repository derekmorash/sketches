class Particle {
  PVector pos;
  PVector vel;
  PVector acc;
  int maxSpeed = 2;
  
  Particle(PVector newPos) {
    pos = newPos;
    vel = new PVector(0,0);
    acc = new PVector(0,0);
  }
  
  void update() {
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
    edges();
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void follow(PVector[] field) {
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    int fieldIndex = 0;// x + y * cols;
    
    if (x >= 0 && x < cols && y >= 0 && y < rows) {
      fieldIndex = x + y * cols;
      applyForce(field[fieldIndex]);
    }
  }
  
  void show() {
    strokeWeight(2);
    stroke(255, 150);
    point(pos.x, pos.y);
  }
  
  private void edges() {
    if (pos.x > width) {
      pos.x = 0;
    } else if (pos.x < 0) {
      pos.x = width;
    }
    if (pos.y > height) {
      pos.y = 0;
    } else if (pos.y < 0) {
      pos.y = height;
    }
  }
}