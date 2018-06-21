import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

import 'package:chewie/chewie.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class VideoApp extends StatefulWidget {
  var videourl;

  @override
  _VideoAppState createState() => _VideoAppState(videourl);

  VideoApp({Key key, @required this.videourl}) : super(key: key);
}

class _VideoAppState extends State<VideoApp> {
  TargetPlatform _platform;
  VideoPlayerController _controller;

  var videourl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    _controller = new VideoPlayerController.network(
//      'https://flutter.github.io/assets-for-api-docs/videos/butterfly.mp4',
//    );
  _controller = new VideoPlayerController.network(widget.videourl);

  }

  Widget _buildVideo() {
    print(videourl);

    return new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Chewie(_controller,
            aspectRatio: 3 / 2, autoPlay: false, looping: true),
        new Text(videourl),
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new GestureDetector(
              child: new Icon(Icons.play_arrow),
              onTap: () {
                _controller.play();
              },
            ),
            new GestureDetector(
              child: new Icon(Icons.pause_circle_filled),
              onTap: () {
                _controller.pause();
              },
            ),
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: _buildVideo(),
    );
//    return new Expanded(
//      child: new Center(
//        child: new Chewie(
//          _controller,
//          aspectRatio: 3 / 2,
//          autoPlay: true,
//          looping: true,
//
//          // Try playing around with some of these other options:
//
////          showControls: true,
////          materialProgressColors: new ChewieProgressColors(
////            playedColor: Colors.red,
////            handleColor: Colors.blue,
////            backgroundColor: Colors.grey,
////            bufferedColor: Colors.lightGreen,
////          ),
////          placeholder: new Container(
////            color: Colors.grey,
////          ),
//          autoInitialize: true,
//        ),
//      ),
//    );
  }

  _VideoAppState(@required this.videourl);
}
