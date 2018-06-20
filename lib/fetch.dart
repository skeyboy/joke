import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import './model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

abstract class FetchClass<Model> {
  String type;
  String page = "1";

  FetchClass({this.type, this.page});

  Future<AllModel> fetch() async {
    final response = await new http.Client()
        .get("https://www.apiopen.top/satinGodApi?type=${type}&page=${page}");
    return new AllModel().fromJson(json.decode(response.body));
  }
}

class AllFetch extends FetchClass<AllModel> {
  AllFetch(String type, String page) : super(type: type, page: page);
}

class TxtFetch extends AllFetch {
  TxtFetch(String type, String page) : super(type, page);
}

class ImgFetch extends AllFetch {
  ImgFetch(String type, String page) : super(type, page);
}

class GifFetch extends ImgFetch {
  GifFetch(String type, String page) : super(type, page);
}

class VideoFetch extends AllFetch {
  VideoFetch(String type, String page) : super(type, page);
}

class FetchComments {
  Future<Comments> fetch(int id, int page) async {
    final response = await new http.Client()
        .get("https://www.apiopen.top/satinCommentApi?id=${id}&page=${page}");
//    return response.body;
    return new Comments().fromJson(json.decode(response.body));
  }
}
