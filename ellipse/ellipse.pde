//ファイル名を変えたために開けなくなる可能性があったので再提出させていただきました

import ddf.minim.spi.*;   //minumというライブラリをimport
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
FFT fft;
Minim minim; 
AudioPlayer song;

int count=0;
color col = color(random(255), random(255), random(255)); //色をランダムに設定

void setup()
{
  size(640, 480);//画面の大きさを設定

  minim = new Minim(this);    //minimのクラスを生成
  song = minim.loadFile("music.mp3"); //音楽を読み込む
  song.play();                //音楽を流す
  smooth(); 
  fft = new FFT(song.bufferSize(), song.sampleRate());//fftクラスを生成
}

void draw()
{

  background(250, 250, 250); //背景の色を指定
  fft.forward(song.mix); //音と動きをリンクさせる
  for (int i = 0; i < 5; i++)//丸を５つ生成
  { 

    float level = fft.getBand(i%fft.specSize());//収縮の振り幅を設定
    level *= (float)(i%fft.specSize()+1)*0.01; 
    level -= 0.1; 

    count++;
    if (count % 100 == 0) {//色の変わる間隔を設定
      col = color(random(255), random(255), random(255));
    }
    fill(col); //丸の色を指定
    noStroke(); //丸の縁をなくす

    ellipse(100 + 100 * i, 480 / 2, 30 + 20*level, 30 + 20*level);//丸の条件を設定
  }
}