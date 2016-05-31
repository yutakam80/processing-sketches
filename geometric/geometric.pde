import processing.pdf.*;

float centerX, centerY;
float gridNum = 10;
float gridSize = 0.5;

void setup() {
  size(847, 595); //A4
  noLoop();
  beginRecord(PDF, "export.pdf");

  colorMode(HSB, 100);

  background(60, 40, 10, 100);
  centerX = width / 2;
  centerY = height / 2;
}

void draw() {

  // Circle
  int radius1 = 120;
  int loopNum1 = 20;
  float ratio1 = 360 / loopNum1;
  for (int i=0; i<loopNum1; i++) {
    float x = cos(radians(ratio1 * i)) * radius1 + centerX;
    float y = sin(radians(ratio1 * i)) * radius1 + centerY;
    float size = radius1 * 2;

    blendMode(DODGE);
    float h = map(i, 0, loopNum1, 10, 60);
    color fillColor = color(h, 60, 80, 8);

    Circle circle = new Circle(x, y, size, fillColor);
    circle.display();
  }

  // Grid
  drawGrid();

  endRecord();
}

void drawGrid() {
  blendMode(BLEND);
  fill(0, 0, 80, 20);

  float windowRatio = (float)height / (float)width;
  float posX = width / gridNum;

  for (int x=1; x<gridNum; x++) {
    rect(posX * x, 0, gridSize, height);
  }
  for (int y=1; y<gridNum*windowRatio; y++) {
    rect(0, posX * y, width, gridSize);
  }
}
