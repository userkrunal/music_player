import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/provider/music_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  MusicProvider? mpF;
  MusicProvider? mpT;
  @override
  void initState() {
    Provider.of<MusicProvider>(context,listen: false).initMusic();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    int i=ModalRoute.of(context)!.settings.arguments as int;
    mpF=Provider.of<MusicProvider>(context,listen: false);
    mpT=Provider.of<MusicProvider>(context,listen: true);
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0x4491069F),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 10),
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back,color: Colors.white,size: 28)),
              SizedBox(width: 240),
              Icon(Icons.star_border_outlined,color: Colors.white,size: 28),
              SizedBox(width: 15),
              Icon(Icons.more_vert_outlined,color: Colors.white,size: 28),
              SizedBox(width: 5),
            ]),
          Padding(
            padding: const EdgeInsets.only(top: 90,left: 20,right: 20),
            child: Container(
              height: 45.h,
              width: 100.w,
              decoration: BoxDecoration(image: DecorationImage(
                image: AssetImage("${mpF!.playList[i].img}"),fit: BoxFit.cover
              )
              ),
            ),
          ),
          PlayerBuilder.currentPosition(player: mpF!.assetsAudioPlayer, builder: (context, position) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider(
                  value: position.inSeconds.toDouble(),
                onChanged: (value) {
                    position=Duration(seconds: value.toInt());
                    mpT!.assetsAudioPlayer.seek(position);
                  },
                max: mpT!.musicduration.inSeconds.toDouble(),
                // inactiveColor: Colors.grey,
                // activeColor: Colors.grey.shade400,
                // thumbColor: Colors.white,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${position}",style: TextStyle(color: Colors.white)),
                    Text("${mpT!.musicduration}",style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.refresh,color: Colors.white,size: 30,)),
              IconButton(onPressed: () {
               mpF!.permusic();
              }, icon: Icon(Icons.skip_previous,color: Colors.white,size: 30)),
              FloatingActionButton(onPressed: (){
                if(mpF!.assetsAudioPlayer.isPlaying.value)
                {
                  mpF!.stopmusic();
                }
                else
                {
                  mpF!.playmusic();
                }
              },child: mpF!.isplay?Icon(Icons.pause,color: Colors.white,size: 30):Icon(Icons.play_arrow,color: Colors.white,size: 30)),
              IconButton(onPressed: () {
                mpF!.nextmusic();
              }, icon: Icon(Icons.skip_next,color: Colors.white,size: 30)),
              IconButton(onPressed: () {}, icon: Icon(Icons.repeat,color: Colors.white,size: 30)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(onPressed: (){}, icon: Icon(Icons.share,color: Colors.white,size: 35)),
              IconButton(onPressed: (){}, icon: Icon(Icons.shuffle,color: Colors.white,size: 35)),
              IconButton(onPressed: (){}, icon: Icon(Icons.delete,color: Colors.white,size: 35)),
            ],
          ),
        ],
      ),
    ));
  }
}
