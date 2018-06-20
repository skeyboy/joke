import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'model.dart';
import 'joke.dart';
import 'model.dart';
import 'fetch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class JokeDetail extends StatefulWidget {
  String title;
  String id;

  var item;

  JokeDetail(this.title, this.id, this.item);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _JokeDetailState(title, id, item);
  }
}

class _JokeDetailState extends State<JokeDetail> {
  String title;
  String id;
  Item item;
  String comments;
  FetchComments fetchComments;

  _JokeDetailState(this.title, this.id, this.item);

  @override
  Future initState() {
    // TODO: implement initState
    super.initState();
    fetchComments = new FetchComments();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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

    if (comments != null) {
      print(json.decode(comments));
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(this.item.type),
      ),
      body: new SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            widget,
            new FutureBuilder<Comments>(
                future: fetchComments.fetch(item.soureid, 1),
                builder: (context, snap) {
                  if (mounted == false || snap.hasData == false) {
                    return new Center(
                      child: new CircularProgressIndicator(),
                    );
                  }
                  return new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Text("Hot"),
                      _build(snap.data.data.hot),
                      new Text("Normal"),
                      _buildNormal(snap.data.data.nromal)
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget _buildNormal(Normal normal) {
    return _build(normal);
  }

  Widget _build(Hot hot) {
    List<Widget> list = hot.list.map<Widget>((item) {
      return new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Image.network(
            item.user.profile_image,
            fit: BoxFit.contain,
            height: 40.0,
          ),
          new Expanded(
              child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Text("${item.user.username}",
                  style: new TextStyle(
                      fontSize: 10.0, fontWeight: FontWeight.bold)),
              new Text(
                item.content,
                style: new TextStyle(fontSize: 15.0),
              )
            ],
          )),
          new Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Text("${item.hate_count}"),
              new Text("VS"),
              new Text(" ${item.like_count}")
            ],
          )
        ],
      );
    }).toList();
    return new Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      child: new Column(
        children: list,
      ),
    );
  }
}
