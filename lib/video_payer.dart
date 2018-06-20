import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';

class VideoApp extends StatefulWidget {
  var videourl;

  @override
  _VideoAppState createState() => _VideoAppState(videourl);

  VideoApp({Key key, @required this.videourl}) : super(key: key);
}

class _VideoAppState extends State<VideoApp> {
  TargetPlatform _platform;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new VideoPlayerController.network(videourl);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Chewie(
        _controller,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: true,

        // Try playing around with some of these other options:

//          showControls: true,
//          materialProgressColors: new ChewieProgressColors(
//            playedColor: Colors.red,
//            handleColor: Colors.blue,
//            backgroundColor: Colors.grey,
//            bufferedColor: Colors.lightGreen,
//          ),
//          placeholder: new Container(
//            color: Colors.grey,
//          ),
        autoInitialize: true,
      ),
    );
    return new Expanded(
      child: new Center(
        child: new Chewie(
          _controller,
          aspectRatio: 3 / 2,
          autoPlay: true,
          looping: true,

          // Try playing around with some of these other options:

//          showControls: true,
//          materialProgressColors: new ChewieProgressColors(
//            playedColor: Colors.red,
//            handleColor: Colors.blue,
//            backgroundColor: Colors.grey,
//            bufferedColor: Colors.lightGreen,
//          ),
//          placeholder: new Container(
//            color: Colors.grey,
//          ),
          autoInitialize: true,
        ),
      ),
    );
  }

  VideoPlayerController _controller;
  bool _isPlaying = false;
  var videourl;

  _VideoAppState(@required this.videourl);
}
