class Circle {
  float x;
  float y;
  float size;
  color c;

  Circle(float _x, float _y, float _size, color _c) {
    x = _x;
    y = _y;
    size = _size;
    c = _c;
  }
  void display() {
    pushMatrix();
    translate(x, y);
    noStroke();
    fill(c);
    ellipse(0, 0, size, size);
    popMatrix();
  }
}
