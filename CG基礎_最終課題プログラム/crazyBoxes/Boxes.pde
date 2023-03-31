class Boxes extends ObjectBase {

  float vol;
  float sound;
  float radius;
  float speed;
  float start;
  float set;
  int c;
  int number;

  float speed_x;
  float speed_y;

  Boxes(float x, float y, float v, float s, float r, float sL, float first, float off, int kaisuu, int n) {
    super(x, y);
    vol = v;
    sound = s;
    radius = r;
    speed = sL;
    start = first;
    set = off;
    c = kaisuu;
    number = n;

    speed_x = random(-5, 5);
    speed_y = random(-5, 5);
  }

  void display() {
    if (DNA) {
      vol = map(mouseY, 350, 700, -25, -50);
      sound = map(vol, -25, -30, 1.04, 1 );
      radius = bts_DNA.left.level() * 300 * sound + 30;
      speed = bts_DNA.left.level() * sound + 5;
    } else if (Dynamite) {
      vol = map(mouseY, 350, 700, -25, -50);
      sound = map(vol, -25, -30, 1.04, 1 );
      radius = bts_dynamite.left.level() * 300 * sound + 30;
      speed = bts_dynamite.left.level() * sound + 5;
    } else if (Idol) {
      vol = map(mouseY, 350, 700, -25, -50);
      sound = map(vol, -25, -30, 1.04, 1 );
      radius = bts_idol.left.level() * 300 * sound + 30;
      speed = bts_idol.left.level() * sound + 5;
    } else if (Boy) {
      vol = map(mouseY, 350, 700, -25, -50);
      sound = map(vol, -25, -30, 1.04, 1 );
      radius = bts_boyWithLove.left.level() * 300 * sound + 30;
      speed = bts_boyWithLove.left.level() * sound + 5;
    } else if (Fake) {
      vol = map(mouseY, 350, 700, -25, -50);
      sound = map(volume, -25, -30, 1.04, 1 );
      radius = bts_fakeLove.left.level() * 300 * sound_size + 30;
      speed = bts_fakeLove.left.level() * sound_size + 5;
    } else if (Tiase) {
      vol = map(mouseY, 350, 700, -25, -50);
      sound = map(volume, -25, -30, 1.04, 1 );
      radius = bts_Tiase.left.level() * 300 * sound_size + 30;
      speed = bts_Tiase.left.level() * sound_size + 5;
    } else if (Butter) {
      vol = map(mouseY, 350, 700, -25, -50);
      sound = map(volume, -25, -30, 1.04, 1 );
      radius = bts_Butter.left.level() * 300 * sound_size + 30;
      speed = bts_Butter.left.level() * sound_size + 5;
    }

    for (int i = 0; i < number; i++) {
      pushMatrix();
      translate(posX, posY, -20);
      fill(colors[i]);
      if (c%2 == 0) {
        rotateY(start + set * i);
        rotateX(start / 2 + set * i);
        rotateZ(start / 3 + set * i);
      }
      box(radius);
      popMatrix();
    }
    start += speed;
  }

  // 物体同士が衝突&壁で跳ね返るようにする
  void move() {
    // 壁で跳ね返る
    if (c%2 == 0) {
      posX += speed_x;
      posY += speed_y;
    }
    if (posX < 0) {
      speed_x = -speed_x;
      posX = 0;
    } else if (posX > width) {
      speed_x = -speed_x;
      posX = width;
    }
    if (posY < 0) {
      speed_y = -speed_y;
      posY = 0;
    } else if (posY > height) {
      speed_y = -speed_y;
      posY = height;
    }
    constrain(posX, 0, width);
    constrain(posY, 0, height);
  }
}
