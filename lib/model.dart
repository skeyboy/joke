import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

abstract class Model<T> {
  int code;
  String msg;

  Model fromJson(Map<String, Item> json);
}

class Item {
  String type;
  String text;
  String username;
  String uid;
  String header;
  int comment;
  dynamic top_commentsVoiceuri;
  dynamic top_commentsContent;
  dynamic top_commentsHeader;
  dynamic top_commentsName;
  String passtime;
  int soureid;
  int up;
  int down;
  int forward;
  String image;
  String gif;
  String thumbnail;
  dynamic video;

  Item({
    @required this.type,
    @required this.text,
    @required this.username,
    @required this.uid,
    @required this.header,
    @required this.comment,
    @required this.passtime,
    @required this.soureid,
  });

  void forOther(Map<String, dynamic> json) {
    top_commentsContent = json['top_commentsContent'];
    top_commentsVoiceuri = json['top_commentsVoiceuri'];
    top_commentsHeader = json['top_commentsHeader'];
    top_commentsName = json['top_commentsName'];
    up = json['up'];
    down = json['down'];
    forward = json['forward'];
    image = json['image'];
    gif = json['gif'];
    video = json['video'];
    thumbnail = json['thumbnail'];
  }

  @override
  String toString() {
    // TODO: implement toString
    return "${type} ${username}";
  }
}

class AllModel extends Model {
  List<Item> data;

  @override
  Model fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson

    code = json['code'];
    msg = json['msg'];
    print(msg);

    List<Item> list = new List();

    List<Map<String, dynamic>> jList =
        json['data'].cast<Map<String, dynamic>>();
    list.addAll(jList.map<Item>((item) {
      Item itemModel = new Item(
          type: item['type'],
          text: item['text'],
          username: item['username'],
          uid: item['uid'],
          header: item['header'],
          comment: item['comment'],
          passtime: item['passtime'],
          soureid: item['soureid']);
      itemModel.forOther(item);
      return itemModel;
    }));
    data = list;
    print(data);
    return this;
  }
}

class TextModel extends AllModel {}

class ImageModel extends AllModel {}

class GifModel extends AllModel {}

class VideoModel extends AllModel {}

class Comments extends Model {
  CommentItem data;
  var body;

  @override
  Model fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson

    code = json['code'];
    msg = json['msg'];
    body = json;
    data = new CommentItem.fromJson(json['data']);
    return this;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "${msg} ${code} ${data}";
  }
}

class CommentItem {
  int author_uid;
  Hot hot;
  Normal nromal;
  var hotJson;

  CommentItem(
      {this.author_uid,
      this.hotJson,
      @required this.hot,
      @required this.nromal});

  factory CommentItem.fromJson(Map<String, dynamic> json) {
    return new CommentItem(
        author_uid: json['author_uid'],
        hotJson: json['hot'],
        hot: new Hot().fromJson(json['hot']),
        nromal: new Normal().fromJson(json['normal']));
  }

  @override
  String toString() {
    // TODO: implement toString
    return "${author_uid} ${hot} ${nromal}";
  }
}

class Hot {
  Info info;
  List<Comment> list = [];

  Hot fromJson(Map<String, dynamic> json) {
    dynamic i = json['list'].cast<Map<String, dynamic>>().map<Comment>((item) {
      return new Comment.fromJson(item);
    });
    list.addAll(i);
    info = new Info(json['count'], json['np']);
    return this;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "${info} ${list}";
  }
}

class Normal extends Hot {
  @override
  Hot fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    return super.fromJson(json);
  }
}

class Info {
  dynamic count = 0;
  dynamic np = 0;

  Info(this.count, this.np);

  @override
  String toString() {
    // TODO: implement toString
    return "${count} ${np}";
  }
}

class Comment {
  User user;
  String type;
  int status;
  String content;
  String ctime;
  int like_count;
  int hate_count;

  Comment(
      {@required this.user,
      this.type,
      this.status,
      this.hate_count,
      this.like_count,
      @required this.content,
      @required this.ctime});

  factory Comment.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> uItem = json['user'];

    return new Comment(
        hate_count: json['hate_count'],
        like_count: json['like_count'],
        user: new User(
            profile_image: uItem['profile_image'],
            sex: uItem['sex'],
            username: uItem['username']),
        content: json['content'],
        ctime: json['ctime']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "${user}";
  }
}

class User {
  int id;
  bool is_vip;
  String personal_page;
  String profile_image;
  dynamic qq_uid;
  String qzone_uid;
  String sex;
  String total_cmt_like_count;
  String username;

  User(
      {this.id,
      this.is_vip,
      this.personal_page,
      @required this.profile_image,
      this.qq_uid,
      this.qzone_uid,
      @required this.sex,
      this.total_cmt_like_count,
      @required this.username});

  User fromJson(Map<String, dynamic> json) {
    return new User(
        profile_image: json['profile_image'],
        sex: json['sex'],
        username: json['username']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return "${username} ${profile_image}";
  }
}
