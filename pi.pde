float r = 200;
int total = 0;
int circle = 0;
int prevY = 0;

void setup() {
  size(402, 502);
  // set up drawing defaults
  background(0);
  translate(width/2, 201);
  stroke(255);
  strokeWeight(4);
  noFill();
  ellipse(0, 0, r*2, r*2);
  rectMode(CENTER);
  rect(0, 0, r*2, r*2);
  textSize(20);
  textAlign(CENTER, TOP);
  rectMode(CORNER);
  frameRate(600);
}

void draw() {
  // Store the translation so we can delete it later
  pushMatrix();
  // Make the center the middle of the circle
  translate(width/2, 201);
  double diff = 0;
  double pi = 0;
  float x = random(-r, r);
  float y = random(-r, r);
  total++;
  // If the randomly chose location is within the circle
  if (x * x + y * y < r * r) {
    circle++;
    stroke(0, 0, 255);
  }
  // Otherwise
  else stroke(255, 0, 0);
  strokeWeight(5);
  point(x, y);
  // Estimate Pi via the Monte Carlo method
  // Explanation: https://academo.org/demos/estimating-pi-monte-carlo/
  pi = (double)4 * ((double)circle / (double)total);
  // Difference between our estimate and pi
  diff = Math.PI - pi;
  // Moved graphing out of draw because it takes so many
  // messy lines to draw anything in processing
  graph(pi, diff);
}

void graph (double pi, double diff) {
  popMatrix();
  noStroke();
  fill(0);
  // Draw black box over previous text
  rect(180,403,45,30);
  stroke(255,255,255);
  strokeWeight(3);
  // Draw the base "pi" line on the graph
  line(0,height-50,width,height-50);
  stroke(0,255,0);
  // Map the difference * 300 to a Y coordinate
  int curY = (int)((height-50)+(float)diff*300);
  // Set bounds so our graph doesn't draw over the "raindrops"
  if (prevY > height) prevY = height;
  if (prevY < 403) prevY = 403;
  if (curY > height) curY = height;
  if (curY < 403) curY = 403;
  // Draw the green graph line logorithmically time wise
  line(sqrt(frameCount)*3-1,prevY,sqrt(frameCount)*3,curY);
  // Set the previous Y so we can draw a line from it next frame
  prevY = (int)((height-50)+(float)diff*300);
  fill(255);
  // Display our current estimate
  text(String.format("%.2f",pi), width/2, 410);
  saveFrame("#####.png");
}
