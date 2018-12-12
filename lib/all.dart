import 'package:flutter/material.dart';

import './joke.dart';
import './joke_detail.dart';
import './model.dart';
import 'fetch.dart';
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

  Widget loadingView() {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[new CircularProgressIndicator(), new Text("努力加载数据")],
      ),
    );
  }


  Widget buildItem(Item item) {
    Widget widget;
    if (item.type == "gif") {
      widget = new GifWidget(item);
    } else if (item.type == "image") {
      widget = new ImageWidget(item);
    } else if (item.type == "video") {
      widget = new VideoWidget(item);
    } else {
      widget = new TextWidget(item);
    }

    return new GestureDetector(
      onTap: () async {
        final result = await Navigator.push(context,
            new MaterialPageRoute(builder: (BuildContext ctx) {
          return new JokeDetail(item.text, "${item.soureid}", item);
        }));
      },
      child: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (isLoading) {
      return new Column(
        children: <Widget>[new CircularProgressIndicator()],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      );
    }
    return new Column(children: <Widget>[
      ListView.builder(
        itemBuilder: (BuildContext build, int index) {
          return buildItem(_items[index]);
        },
        itemCount: _items.length,
        controller: _controller,
      ),
      more && isLoading ? loadingView(): null
    ],)
   }

  List<Item> _items;
  bool isLoading = true;
  bool more = false;
  ScrollController _controller;

  void _getMoreData(int page) {
    fetch().noFutureFetch(page,(AllModel allModel) {
      _items.addAll(allModel.data.map<Item>((Item i) {
        return i;
      }));
      setState(() {
        _items = _items;
        isLoading = false;
        more = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _controller = new ScrollController();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        more = true;
        isLoading = true;
        page = page +1;
        _getMoreData(page);
      }
    });

    super.initState();
    _items = new List();
    isLoading = true;
    fetch().noFutureFetch(1,(AllModel allModel) {
      if (allModel.data.length > 0){
        _items.clear();
      }
      setState(() {
        _items = allModel.data;
        isLoading = false;
      });
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
