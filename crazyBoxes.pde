// ボタンの色がおかしい→改善：HSB表記だったためおかしくなっていた→改善：ボタンの色を灰色ベースの
// グラデーションにすれば完成
// 音楽を切り替えたときに他の物体の半径が切り替わらない→改善したものの、音楽の切り替えに不備あり
// →改善：あとは音楽をサビの部分にする/ダンス動画をとって編集のときに右上に載せる/バターと血汗涙を追加
// 物体同士が衝突時に分裂させる

import ddf.minim.*;

ArrayList<ObjectBase> list = new ArrayList<ObjectBase>();
Boxes boxes;

Minim minim;

//サウンドファイルのプレーヤーを定義
AudioPlayer bts_DNA, bts_dynamite, bts_idol, bts_boyWithLove;
AudioPlayer bts_fakeLove, bts_Tiase, bts_Butter;

PImage dna;
PImage dynamite;
PImage idol;
PImage boy;
PImage fakeLove;
PImage tiase;
PImage butter;

boolean DNA = true;
boolean Fake, Dynamite, Idol, Boy, Tiase, Butter = false;

// 音量を決める変数
float value;

float volume;
float sound_size;
float radiusL;
float speed_L;

float speedX;
float speedY;

int count = 0;

float a = 0;
int NUM = 128;
float offset = PI / NUM;
color[] colors = new color[NUM];

void setup() {
  size(1980, 1080, P3D);
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
  frameRate(30);

  dna = loadImage("bts_DNA.png");
  tiase = loadImage("血汗涙.png");
  tiase.resize(tiase.width/3*2, tiase.height/3*2);
  idol = loadImage("bts_idol01.jpg");
  fakeLove = loadImage("fake love.jpg");
  fakeLove.resize(fakeLove.width*2, fakeLove.height*2);
  boy = loadImage("boywithlove.jpg");
  dynamite = loadImage("BTS 'Dynamite' ONLINE GLOBAL MEDIA DAY_2.jpg");
  butter = loadImage("BTS_Butter-GlobalPress-3.png");

  list = new ArrayList();

  for (int i = 0; i < NUM; i++) {
    colors[i] = color(i * 2 + 100, 70, 100, 25);
  }
  lights();

  minim = new Minim(this);

  //サウンドファイルを読み込む
  bts_DNA = minim.loadFile("BTS (방탄소년단) _DNA_ Official MV.wav", 512);
  bts_dynamite = minim.loadFile("BTS (방탄소년단) _Dynamite_ Official MV.wav", 512);
  bts_idol = minim.loadFile("BTS (방탄소년단) _IDOL_ Official MV.wav", 512);
  bts_boyWithLove = minim.loadFile("BTS (방탄소년단) _작은 것들을 위한 시 (Boy With Luv) (feat. Halsey)_ Official MV.wav", 512);
  bts_fakeLove = minim.loadFile("BTS (방탄소년단) _FAKE LOVE_ Official MV.wav", 512);
  bts_Tiase = minim.loadFile("BTS (防弾少年団) _血、汗、涙 -Japanese Ver.-_ Official MV.wav", 512);
  bts_Butter = minim.loadFile("BTS (방탄소년단) _Butter_ Official MV.wav", 512);
  bts_DNA.play();
}

void draw() {
  background(0);

  ambientLight(63, 31, 31);
  directionalLight(255, 255, 255, -1, 0, 0);
  pointLight(63, 127, 255, frameCount%720, frameCount%720, 200);
  spotLight(100, 100, 100, frameCount%720, frameCount%720, 200, 0, 0, -1, PI, 2);

  if (DNA == true) {
    volume = map(mouseY, 350, 700, -25, -50);
    sound_size = map(volume, -25, -30, 1.04, 1 );
    radiusL = bts_DNA.left.level() * 300 * sound_size + 30;
    speed_L = bts_DNA.left.level() * sound_size + 5;
  } else if (Dynamite == true) {
    volume = map(mouseY, 350, 700, -25, -50);
    sound_size = map(volume, -25, -30, 1.04, 1 );
    radiusL = bts_dynamite.left.level() * 300 * sound_size + 30;
    speed_L = bts_dynamite.left.level() * sound_size + 5;
  } else if (Idol == true) {
    volume = map(mouseY, 350, 700, -25, -50);
    sound_size = map(volume, -25, -30, 1.04, 1 );
    radiusL = bts_idol.left.level() * 300 * sound_size + 30;
    speed_L = bts_idol.left.level() * sound_size + 5;
  } else if (Boy == true) {
    volume = map(mouseY, 350, 700, -25, -50);
    sound_size = map(volume, -25, -30, 1.04, 1 );
    radiusL = bts_boyWithLove.left.level() * 300 * sound_size + 30;
    speed_L = bts_boyWithLove.left.level() * sound_size + 5;
  } else if (Fake) {
    volume = map(mouseY, 350, 700, -25, -50);
    sound_size = map(volume, -25, -30, 1.04, 1 );
    radiusL = bts_fakeLove.left.level() * 300 * sound_size + 30;
    speed_L = bts_fakeLove.left.level() * sound_size + 5;
  } else if (Tiase == true) {
    volume = map(mouseY, 350, 700, -25, -50);
    sound_size = map(volume, -25, -30, 1.04, 1 );
    radiusL = bts_Tiase.left.level() * 300 * sound_size + 30;
    speed_L = bts_Tiase.left.level() * sound_size + 5;
  } else if (Butter == true) {
    volume = map(mouseY, 350, 700, -25, -50);
    sound_size = map(volume, -25, -30, 1.04, 1 );
    radiusL = bts_Butter.left.level() * 300 * sound_size + 30;
    speed_L = bts_Butter.left.level() * sound_size + 5;
  }

  perspective();
  pushMatrix();
  if (DNA) {
    pushMatrix();
    imageMode(CENTER);
    translate(width/2, height/2);
    image(dna, 0, 0);
    popMatrix();
  } else if (Tiase) {
    pushMatrix();
    imageMode(CENTER);
    translate(width/2, height/2);
    image(tiase, 0, 0);
    popMatrix();
  } else if (Idol) {
    pushMatrix();
    imageMode(CENTER);
    translate(width/2, height/2);
    image(idol, 0, 0);
    popMatrix();
  } else if (Fake) {
    pushMatrix();
    imageMode(CENTER);
    translate(width/2, height/2);
    image(fakeLove, 0, 0);
    popMatrix();
  } else if (Boy) {
    pushMatrix();
    imageMode(CENTER);
    translate(width/2, height/2);
    image(boy, 0, 0);
    popMatrix();
  } else if (Dynamite) {
    pushMatrix();
    imageMode(CENTER);
    translate(width/2, height/2);
    image(dynamite, 0, 0);
    popMatrix();
  } else if (Butter) {
    pushMatrix();
    imageMode(CENTER);
    translate(width/2, height/2);
    image(butter, 0, 0);
    popMatrix();
  } 
  for ( int i=0; i<list.size(); i++ ) {
    list.get(i).display();
    list.get(i).move();

    // それぞれの物体が反発するようにしたい
    //if (dist(boxes.posX, boxes.posY, boxes.posX, boxes.posY) < 50) {
    //  boxes.speed_x = -boxes.speed_x;
    //  boxes.speed_y = -boxes.speed_y;
    //}
  }

  for (int i = 0; i < NUM; i++) {
    pushMatrix();
    translate(width / 2, height / 2, -20);
    fill(colors[i]);
    if (count%2 == 0) {
      rotateY(a + offset * i);
      rotateX(a / 2 + offset * i);
      rotateZ(a / 3 + offset * i);
    }
    box(radiusL);
    popMatrix();
  }
  a += speed_L;
  popMatrix();

  // 音楽を切り替えるためのボタンをつくっていく
  ortho();
  pushMatrix();
  translate(width/2-450, height/8*7);
  for (int i=0; i<7; i++) {
    pushMatrix();
    translate(150*i, 0);
    // もっとグレーに近い感じにしたい
    fill(0, 0, 20*i+10);
    ellipse(0, 0, 100, 100);
    popMatrix();
  }
  popMatrix();
}

void mousePressed() {
  // DNA
  if (dist(mouseX, mouseY, width/2-450, height/8*7) < 100/2) {
    //bts_DNA.pause();
    bts_Tiase.pause();
    bts_idol.pause();
    bts_boyWithLove.pause();
    bts_fakeLove.pause();
    bts_dynamite.pause();
    bts_Butter.pause();
    if (bts_DNA.isPlaying() == false) {
      bts_DNA.rewind();
      bts_DNA.play();
    }
    DNA = true;
    Tiase = false;
    Idol = false;
    Boy = false;
    Fake = false;
    Dynamite = false;
    Butter = false;
  } 
  // 血汗涙
  else if (dist(mouseX, mouseY, width/2-450+150, height/8*7) < 100/2) {
    bts_DNA.pause();
    //bts_Tiase.pause();
    bts_idol.pause();
    bts_boyWithLove.pause();
    bts_fakeLove.pause();
    bts_dynamite.pause();
    bts_Butter.pause();
    if (bts_Tiase.isPlaying() == false) {
      bts_Tiase.rewind();
      bts_Tiase.play();
    }
    DNA = false;
    Dynamite = false;
    Idol = false;
    Boy = false;
    Fake = false;
    Tiase = true;
    Butter = false;
  } 
  // 左から3つ目のボタン:idol
  else if (dist(mouseX, mouseY, width/2-450+150*2, height/8*7) < 100/2) {
    bts_DNA.pause();
    bts_Tiase.pause();
    //bts_idol.pause();
    bts_boyWithLove.pause();
    bts_fakeLove.pause();
    bts_dynamite.pause();
    bts_Butter.pause();
    if (bts_idol.isPlaying() == false) {
      bts_idol.rewind();
      bts_idol.play();
    }
    DNA = false;
    Dynamite = false;
    Idol = true;
    Boy = false;
    Fake = false;
    Tiase = false;
    Butter = false;
  } 
  // 左から4つめのボタン:FAKE LOVE
  else if (dist(mouseX, mouseY, width/2-450+150*3, height/8*7) < 100/2) {
    bts_DNA.pause();
    bts_Tiase.pause();
    bts_idol.pause();
    bts_boyWithLove.pause();
    //bts_fakeLove.pause();
    bts_dynamite.pause();
    bts_Butter.pause();
    if (bts_fakeLove.isPlaying() == false) {
      bts_fakeLove.rewind();
      bts_fakeLove.play();
    }
    DNA = false;
    Tiase = false;
    Idol = false;
    Boy = false;
    Fake = true;
    Dynamite = false;
    Butter = false;
  }
  // 左から5つ目のボタン:Boy With Love
  else if (dist(mouseX, mouseY, width/2-450+150*4, height/8*7) < 100/2) {
    bts_DNA.pause();
    bts_Tiase.pause();
    bts_idol.pause();
    //bts_boyWithLove.pause();
    bts_fakeLove.pause();
    bts_dynamite.pause();
    bts_Butter.pause();
    if (bts_boyWithLove.isPlaying() == false) {
      bts_boyWithLove.rewind();
      bts_boyWithLove.play();
    }
    DNA = false;
    Tiase = false;
    Idol = false;
    Boy = true;
    Fake = false;
    Dynamite = false;
    Butter = false;
  }
  // 左から6つ目のボタン:Dynamite
  else if (dist(mouseX, mouseY, width/2-450+150*5, height/8*7) < 100/2) {
    bts_DNA.pause();
    bts_Tiase.pause();
    bts_idol.pause();
    bts_boyWithLove.pause();
    bts_fakeLove.pause();
    //bts_dynamite.pause();
    bts_Butter.pause();
    if (bts_dynamite.isPlaying() == false) {
      bts_dynamite.rewind();
      bts_dynamite.play();
    }
    DNA = false;
    Tiase = false;
    Idol = false;
    Boy = false;
    Fake = false;
    Dynamite = true;
    Butter = false;
  }
  // 左から7つ目のボタン:Butter
  else if (dist(mouseX, mouseY, width/2-450+150*6, height/8*7) < 100/2) {
    bts_DNA.pause();
    bts_Tiase.pause();
    bts_idol.pause();
    bts_boyWithLove.pause();
    bts_fakeLove.pause();
    bts_dynamite.pause();
    //bts_Butter.pause();
    if (bts_Butter.isPlaying() == false) {
      bts_Butter.rewind();
      bts_Butter.play();
    }
    DNA = false;
    Tiase = false;
    Idol = false;
    Boy = false;
    Fake = false;
    Dynamite = false;
    Butter = true;
  }
}

void keyPressed() {
  // スペースキーを押して音の再生と一時停止をする
  if (key == ' ') {
    count++;
    //for (int i=0; i<list.size(); i++) {
    //  //boxes.c++;
    //}
    //if (count%2 == 1) {
    //  player.pause();
    //} else {
    //  player.play();
    //}
  } else {
    list.add(new Boxes(mouseX, mouseY, volume, sound_size, radiusL, speed_L, a, offset, count, NUM));
  }
}

void stop() {
  bts_DNA.close();
  bts_dynamite.close();
  bts_idol.close();
  bts_boyWithLove.close();
  bts_fakeLove.close();
  minim.stop();
  super.stop();
}
