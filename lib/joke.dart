import 'package:flutter/material.dart';
import 'model.dart';
import 'package:flutter/cupertino.dart';
import 'video_payer.dart';
import 'package:chewie/chewie.dart';

class TextWidget extends StatelessWidget {
  Item model;

  TextWidget(this.model);

  Widget top(Item model) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new CircleAvatar(
              child: new Image.network(model.header),
            ),
            new Column(
              children: <Widget>[
                new Text(model.username),
                new Text(model.passtime),
                new Text('${model.comment}')
              ],
            )
          ],
        ),
        new Container(
          margin: new EdgeInsets.only(
              left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
          child: new Text(
            model.text,
            style: new TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.normal),
          ),
        )
      ],
    );
  }

  Widget content(BuildContext context, Item model) {
    return new Column();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    return new Text('${ model}');
    return new Container(
      decoration: new BoxDecoration(
          border:
              new Border(top: new BorderSide(color: Colors.grey, width: 10.0))),
      child:  new Column(
          children: <Widget>[
            top(model),
            content(context, model),
          ],
        )
      ,
      margin: new EdgeInsets.all(5.0),
    );
  }
}

class VideoWidget extends TextWidget {
  VideoWidget(Item model) : super(model);

  @override
  Widget content(BuildContext context, Item model) {
    // TODO: implement video
    return   new Container(
        child:
//      new VideoApp(model.video)

            model.video != null
                ? new VideoApp(videourl: model.video)
                : new Image.network(model.thumbnail),

    );
  }
}

class GifWidget extends TextWidget {
  GifWidget(Item model) : super(model);

  @override
  Widget content(BuildContext context, Item model) {
    // TODO: implement video
    return   new Container(
        child: new Image.network(model.gif),
      );
  }
}

class ImageWidget extends GifWidget {
  ImageWidget(Item model) : super(model);

  @override
  Widget content(BuildContext context, Item model) {
    // TODO: implement video
    return  new Container(
        child: new Image.network(model.image),

    );
  }
}
