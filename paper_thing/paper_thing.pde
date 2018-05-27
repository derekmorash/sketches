PVector[] poly1;
PVector[] poly2;
PVector[] poly3;
int n = 100;

PVector biasPos;

PImage paper;

//purple RGB(104, 74, 168)
//red RGB(221, 42, 47)
//yellow RGB(224, 199, 74)
//green RGB(38, 168, 103)
//blue RGB(42, 104, 208)

void setup() {
  size(1400, 1400);
  //noLoop();
  
  //n++;
  poly1 = new PVector[n];
  poly2 = new PVector[n];
  poly3 = new PVector[n];
  
  for (int i = 0; i < n; i++) {
    float x = (width/2) + 300*sin(map(i, 0, n-1, 0, TAU));
    float y = (height/2) + 300*cos(map(i, 0, n-1, 0, TAU));
    poly1[i] = new PVector(x, y);
  }
  for (int i = 0; i < n; i++) {
    float x = (width/2) + 380*sin(map(i, 0, n-1, 0, TAU));
    float y = (height/2) + 380*cos(map(i, 0, n-1, 0, TAU));
    poly2[i] = new PVector(x, y);
  }
  for (int i = 0; i < n; i++) {
    float x = (width/2) + 460*sin(map(i, 0, n-1, 0, TAU));
    float y = (height/2) + 460*cos(map(i, 0, n-1, 0, TAU));
    poly3[i] = new PVector(x, y);
  }
  
  biasPos = new PVector(random(width), random(height/2));
  
  paper = createPaper(createImage(width, height, ARGB));
}

void draw() {
  background(250);
  
  createPoly(poly1, color(221, 42, 47), 4000, 4000);
  createPoly(poly2, color(38, 168, 103), 4000, 6000);
  createPoly(poly3, color(42, 104, 208), 6000, 2000);
  
  //fill(255, 0, 0);
  //ellipse(biasPos.x, biasPos.y, 8, 8);
  
  float newBiasX = map(noise(frameCount * 0.01), 0, 1, -10, 10);//random(-10, 10);
  float newBiasY = map(noise(frameCount * 0.05), 0, 1, -10, 10);//random(-10, 10);
  
  biasPos.add(newBiasX, newBiasY);
  
  if (biasPos.x > width) {
    biasPos.x = width;
  } else if(biasPos.x < 0) {
    biasPos.x = 0;
  }
  
  if (biasPos.y > height) {
    biasPos.y = height;
  } else if(biasPos.y < 0) {
    biasPos.y = 0;
  }

  image(paper,0,0);
  
  //saveFrame("frame-#####.png");
  
  saveFrame("screens/line-######.png");
  if (frameCount >= 680) {
    noLoop();
  }
  println(frameCount);
}

float logMap(float value, float start1, float stop1, float start2, float stop2) {
  start2 = log(start2);
  stop2 = log(stop2);
 
  return exp(start2 + (stop2 - start2) * ((value - start1) / (stop1 - start1)));
}


void createPoly(PVector[] poly, color strokeColor, int dx, int dy) {
  float xPos = biasPos.x;//mouseX;//random(width);
  float yPos = biasPos.y;//mouseY;//random(height);
  PShape s = createShape();
  s.beginShape();
  s.stroke(strokeColor);
  s.strokeWeight(60);
  s.noFill();
  for (int i = 0; i < n; i++) {
    float bias = dist(xPos, yPos, poly[i].x, poly[i].y);
    s.vertex(poly[i].x + dx / logMap(bias, width, 0, dx, 45), poly[i].y + dy / logMap(bias, height, 0, dy, 45));
    //s.vertex(poly[i].x + dx / width, poly[i].y + dy / height);
  }
  s.endShape(CLOSE);
  
  //do gradient
  for (int i = 0; i < 30; i++) {
    s.setStroke(color(0, 0, 0, map(i, 0, 30, 1, 15)));
    shape(s, 0, (30-i)/2);
  }
  
  s.setStroke(strokeColor);
  shape(s, 0, 0);
}





PImage createPaper(PImage img) {
  strokeWeight(1);
  noStroke();
  img.loadPixels();
  for (int x = 0; x < img.width-1; x+=4) {
    for (int y = 0; y < img.height-1; y+=4) {
      //int index = x + img.width*y;
      color paperFill = color(random(205-40, 205+30), 25);
      //img.pixels[index] = paperFill;
      //img.pixels[index+1] = paperFill;
      //img.pixels[index+img.width] = paperFill;
      //img.pixels[index+img.width+1] = paperFill;
      
      img.set(x, y, paperFill);
      img.set(x, y+1, paperFill);
      img.set(x, y+2, paperFill);
      img.set(x, y+3, paperFill);
      img.set(x+1, y, paperFill);
      img.set(x+1, y+1, paperFill);
      img.set(x+1, y+2, paperFill);
      img.set(x+1, y+3, paperFill);
      img.set(x+2, y, paperFill);
      img.set(x+2, y+1, paperFill);
      img.set(x+2, y+2, paperFill);
      img.set(x+2, y+3, paperFill);
      img.set(x+3, y, paperFill);
      img.set(x+3, y+1, paperFill);
      img.set(x+3, y+2, paperFill);
      img.set(x+3, y+3, paperFill);
    }
  }

  for (int i = 0; i<60; i++) {
    //fill(random(130, 215), random(100, 170));
    //rect(random(0, width-2), random(0, height-2), random(1, 3), random(1, 3));
    
    color scratch = color(random(130, 215), random(100, 170));
    int x = floor(random(width));
    int y = floor(random(height));
    img.set(x, y, scratch);
    img.set(x, y+1, scratch);
    img.set(x, y+2, scratch);
    img.set(x+1, y, scratch);
    img.set(x+1, y+1, scratch);
    img.set(x+1, y+2, scratch);
    img.set(x+2, y, scratch);
    img.set(x+2, y+1, scratch);
    img.set(x+2, y+2, scratch);
  }
  
  img.updatePixels();
  
  return img;
}
