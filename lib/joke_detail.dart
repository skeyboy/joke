import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model.dart';
import 'joke.dart';
import 'model.dart';
import 'fetch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

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

  Widget _buildFullImagePage(Widget w, String image) {
    return new GestureDetector(
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext ctx) {
          return new Scaffold(
            backgroundColor: Colors.black45,
            body: new Center(
              child: new Column(
                children: <Widget>[
                  new CachedNetworkImage(
                    imageUrl: image,
                    placeholder: new CircularProgressIndicator(),
                    errorWidget: new Icon(Icons.broken_image),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
              ),
            ),
          );
        }));
      },
      child: w,
    );
  }

  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  Widget _buildSliverApp() {
    Widget widget = null;
    if (item.type == "gif") {
      widget = _buildFullImagePage(new GifWidget(item), item.gif);
    } else if (item.type == "image") {
      widget = _buildFullImagePage(new ImageWidget(item), item.image);
    } else if (item.type == "video") {
      widget = new VideoWidget(item);
    } else {
      widget = new TextWidget(item);
    }

    return new SliverAppBar(
      expandedHeight: 256.0,
      pinned: _appBarBehavior == AppBarBehavior.pinned,
      floating: true,
      snap: true,
      actions: <Widget>[
        new IconButton(
          icon: const Icon(Icons.create),
          tooltip: 'Edit',
          onPressed: () {
            _scaffoldKey.currentState.showSnackBar(const SnackBar(
                content:
                    const Text("Editing isn't supported in this screen.")));
          },
        ),
        new PopupMenuButton<AppBarBehavior>(
          onSelected: (AppBarBehavior value) {
            setState(() {
              _appBarBehavior = value;
            });
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuItem<AppBarBehavior>>[
                const PopupMenuItem<AppBarBehavior>(
                    value: AppBarBehavior.normal,
                    child: const Text('App bar scrolls away')),
                const PopupMenuItem<AppBarBehavior>(
                    value: AppBarBehavior.pinned,
                    child: const Text('App bar stays put')),
                const PopupMenuItem<AppBarBehavior>(
                    value: AppBarBehavior.floating,
                    child: const Text('App bar floats')),
                const PopupMenuItem<AppBarBehavior>(
                    value: AppBarBehavior.snapping,
                    child: const Text('App bar snaps')),
              ],
        ),
      ],
      flexibleSpace: new FlexibleSpaceBar(
        title: new Text(item.type),
        background: new SingleChildScrollView(child: widget,),
      ),
    );
  }

  Widget _buildContent() {
    return new CustomScrollView(
      slivers: <Widget>[
        _buildSliverApp(),
        new SliverList(
            delegate: new SliverChildListDelegate(<Widget>[
          new AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: new SingleChildScrollView(
                child: new Column(
                  children: <Widget>[
                    new FutureBuilder<Comments>(
                        future: fetchComments.fetch(item.soureid, 1),
                        builder: (context, snap) {
                          if (mounted == false || snap.hasData == false) {
                            return new Center(
                              child: new Column(
                                children: <Widget>[
                                  new CircularProgressIndicator()
                                ],
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
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
              ))
        ]))
      ],
    );
  }

  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      key: _scaffoldKey,
      body: _buildContent(),
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
          new CachedNetworkImage(
            imageUrl: item.user.profile_image,
            placeholder: new Container(
              width: 40.0,
              height: 40.0,
              child: new Icon(Icons.image),
            ),
            fit: BoxFit.contain,
            width: 40.0,
            errorWidget: new Container(
              width: 40.0,
              height: 40.0,
              child: new Icon(Icons.broken_image),
            ),
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

enum AppBarBehavior { normal, pinned, floating, snapping }
