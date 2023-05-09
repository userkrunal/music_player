import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:music_player/model/music_model.dart';

class MusicProvider extends ChangeNotifier
{
  int? musicindex;

  List playList=[
    MusicModel(name: "Leja re",path: "assets/music/leja.mp3",img: "assets/images/img_2.png"),
    MusicModel(name: "Galliyan",path: "assets/music/m1.mp3",img: "assets/images/img_6.png"),
    MusicModel(name: "Ladki Badi Anjani Hai ",path: "assets/music/m2.mp3",img: "assets/images/img_4.png"),
    MusicModel(name: "Chand Tare Phool Shabnam",path: "assets/music/m3.mp3",img: "assets/images/img_5.png"),
    MusicModel(name: "Humein Tumse Hua Hai Pyar ",path: "assets/music/m4.mp3",img: "assets/images/img_3.png"),
  ];
  AssetsAudioPlayer assetsAudioPlayer= AssetsAudioPlayer();
  bool isplay=false;
  Duration musicduration=Duration(seconds: 0);

  List<Audio> musicList=[
    Audio("assets/music/leja.mp3"),
    Audio("assets/music/m1.mp3"),
    Audio("assets/music/m2.mp3"),
    Audio("assets/music/m3.mp3"),
    Audio("assets/music/m4.mp3"),
  ];

  initMusic()
  {
    assetsAudioPlayer.open(
      autoStart: false,
      showNotification: true,
      Playlist(
        audios: musicList
      ),
    );
    audioduration();
  }

  playmusic()
  {
    isplay=true;
    assetsAudioPlayer.play();
    notifyListeners();
  }

  stopmusic()
  {
    isplay=false;
    assetsAudioPlayer.pause();
    notifyListeners();
  }

  nextmusic()
  {
    assetsAudioPlayer.next();
    isplay=true;
    notifyListeners();
  }
  permusic()
  {
    assetsAudioPlayer.previous();
    isplay=true;
    notifyListeners();
  }
  audioduration()
  {
    assetsAudioPlayer.current.listen((event) {
      musicduration=event!.audio.duration;
    });
  }

  musicindexpass(int index)
  {
    musicindex=index;
    notifyListeners();
  }

}