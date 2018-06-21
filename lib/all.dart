import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import './model.dart';
import 'fetch.dart';
import './joke.dart';
import 'package:http/http.dart' as http;
import './joke_detail.dart';
import 'video_payer.dart';
import 'joke_detail.dart';

class All extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _AllState();
  }
}

class _AllState extends State<All> {
  FetchClass fetch() {
    return new AllFetch("1", "1");
  }

  int page = 1;
  List<Item> modes = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    modes.clear();
    modes = null;
    page = 1;
  }

  Widget _buildFutureViews() {
    return new FutureBuilder<AllModel>(
        future: fetch().fetch(),
        builder: (cxt, snap) {
          if (mounted == false || snap.hasData == false) {
            return new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Text("努力加载数据")
                ],
              ),
            );
          }
          List<Widget> children =
              snap.data.data.cast<Item>().map<Widget>((item) {
            Widget widget = null;
            if (item.type == "gif") {
              widget = new GifWidget(item);
            } else if (item.type == "image") {
              widget = new ImageWidget(item);
            } else if (item.type == "video") {
              widget = new VideoWidget(item);
            } else {
              widget = new TextWidget(item);
            }
//            widget = new Text("${item}");
            return new GestureDetector(
              onTap: () async {
                final result = await Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext ctx) {
                  return new JokeDetail(item.text, "${item.soureid}", item);
                }));
              },
              child: widget,
            );
          }).toList();

          return new Column(
            children: children,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (mounted == false) {
      return new Column(
        children: <Widget>[new CircularProgressIndicator()],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      );
    }
    return new SingleChildScrollView(
      child: _buildFutureViews(),
    );
    return new FutureBuilder<AllModel>(
        future: fetch().fetch(),
        builder: (cxt, snap) {
          if (mounted == false || snap.hasData == false) {
            return new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new CircularProgressIndicator(),
                  new Text("努力加载数据")
                ],
              ),
            );
          }
          List<Widget> children =
              snap.data.data.cast<Item>().map<Widget>((item) {
            Widget widget = null;
            if (item.type == "gif") {
              widget = new GifWidget(item);
            } else if (item.type == "image") {
              widget = new ImageWidget(item);
            } else if (item.type == "video") {
              widget = new VideoWidget(item);
            } else {
              widget = new TextWidget(item);
            }
//            widget = new Text("${item}");
            return new GestureDetector(
              onTap: () {
                Navigator.push(context,
                    new MaterialPageRoute(builder: (BuildContext ctx) {
                  return new JokeDetail(item.text, "${item.soureid}", item);
                }));
              },
              child: widget,
            );
          }).toList();

          return new Column(
            children: children,
          );
        });
  }
}

class Txt extends All {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _TxtState();
  }
}

class _TxtState extends _AllState {
  @override
  FetchClass fetch() {
    // TODO: implement fetch
    return new TxtFetch("2", "${page}");
  }
}

class Img extends All {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ImageState();
  }
}

class _ImageState extends _AllState {
  @override
  FetchClass fetch() {
    // TODO: implement fetch
    return new ImgFetch("4", "${page}");
  }
}

class Gif extends Img {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _GifState();
  }
}

class _GifState extends _ImageState {
  @override
  FetchClass fetch() {
    // TODO: implement fetch
    return new GifFetch("4", "${page}");
  }
}

class Video extends All {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _VideoState();
  }
}

class _VideoState extends _AllState {
  @override
  FetchClass fetch() {
    // TODO: implement fetch
    return new VideoFetch("5", "${page}");
  }
}
