import 'package:flutter/material.dart';
import 'all.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _BodyState();
  }
}

class _BodyState extends State<Body> {
  final pages = [new All(), new Txt(), new Img(), new Gif(), new Video()];
  int _curIndex = 1;
  List<BottomNavigationBarItem> tabs = new List();
   String type = "";
  List<String> titles = ["全部", "笑话", "图片", "动图", "视频"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     List<IconData> iconIndicators = [
      Icons.all_inclusive,
      Icons.book,
      Icons.image,
      Icons.gif,
      Icons.ondemand_video
    ];

    int index = 0;

    pages.forEach((i) {
      tabs.add(new BottomNavigationBarItem(
          icon: new Icon(iconIndicators[index]),
          title: new Text(titles[index])));
      index++;
    });
    setState(() {
      type = titles[_curIndex];
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('快乐满满${type}'),
        centerTitle: true,
      ),
      bottomNavigationBar: new BottomNavigationBar(
        items: tabs,
        currentIndex: _curIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _curIndex = index;
            type = titles[_curIndex];
          });
        },
      ),
      drawer: new Container(),
      body:new IndexedStack(
        index: _curIndex,
        children: pages,
      )
    );
  }
}
