import 'package:flutter/material.dart';
import 'package:music_player/provider/music_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen> {
  MusicProvider? mpF;
  MusicProvider? mpT;
  @override
  Widget build(BuildContext context) {
    mpF=Provider.of<MusicProvider>(context,listen: false);
    mpT=Provider.of<MusicProvider>(context,listen: true);
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            height: 30.h,
            width: 100.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/img.png"),fit: BoxFit.cover
              )
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 63.5.h,
            width: 100.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/img_1.png"),fit: BoxFit.cover
              )
            ),
            child: ListView.builder(itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  mpF!.musicindexpass(index);
                  Navigator.pushNamed(context, 'music',arguments: index);
                },
                child: ListTile(
                  title: Text("${mpF!.playList[index].name}",style: TextStyle(color: Colors.white)),
                  leading: Container(
                    height: 70,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(image: AssetImage("${mpF!.playList[index].img}"),fit: BoxFit.cover)
                    ),
                  ),
                ),
              ),
            ),itemCount: mpF!.playList.length),
          )
        ],
      ),
    ));
  }
}
