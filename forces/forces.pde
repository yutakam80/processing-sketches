Circle[] circles = {};
int num = 150;

void setup() {
  size(400, 400);
  background(0);
  smooth();
  colorMode(HSB, 100);

  noStroke();

  for (int i=0; i<num; i++) {
    Circle circle = new Circle();
    circles = (Circle[])append(circles, circle);
  }
}

void draw() {
  background(0);

  for (Circle circle : circles) {
    circle.update();
  }
}

class Circle {
  float radius = random(1, 5);
  int speedLimit = 5;
  int separation = 20;
  PVector location = new PVector(random(0, width), random(0, height)); // 位置
  PVector velocity = new PVector(-2, 1); // 速さ
  PVector acceleration = new PVector(); // 加速度

  Circle() {

  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    // Add acceleration
    PVector mouse = new PVector(mouseX,mouseY); // マウスの位置を取得
    PVector direction = PVector.sub(mouse, location); // マウス位置と物体の距離を算出
    direction.normalize(); // ベクトルの正規化
    direction.mult(0.2); // 0.2を乗算してスピードを調整
    acceleration = direction; // 距離を加速度に代入

    // Separate
    for (Circle circle : circles) {
      if (circle != this) {
        float distObject = circle.location.dist(this.location); // 他の物体と自分との距離を算出
        if (distObject < separation) {
          PVector diff = PVector.sub(this.location, circle.location); // 他の物体と自分との距離の差分を算出
          diff.normalize();
          applyForce(diff); // 差分を加速度に加算
        }
      }
    }

    velocity.add(acceleration); // 加速度を加算する
    location.add(velocity); // 位置に速さを加算する
    velocity.limit(speedLimit); // 速さを制限する

    float dist = mouse.dist(location);
    float h = map(dist, 0, height, 0, 20);
    float size = radius * velocity.mag();

    pushMatrix();
    translate(location.x, location.y);
    blendMode(LIGHTEST);
    fill(h, 100, 100, 80);
    ellipse(0, 0, size, size);
    popMatrix();

    // 座標が画面外になったら
    if (location.x > width) {
      location.x = 0;
    } else if (location.x < 0) {
      location.x = width;
    }
    if (location.y > height) {
      location.y = 0;
    } else if (location.y < 0) {
      location.y = height;
    }
  }
}
