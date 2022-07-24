import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _scrollController = ScrollController();
  final _headersMinExtent = <int, double>{};
  final itemList = List.filled(40, "item");

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      _scrollListener();
    });
  }

  _scrollListener() {
    var n = 0;
    setState(() {
      _headersMinExtent.forEach((key, value) {
        _headersMinExtent[key] =
            (key * 30 + n * 40 + 190 - _scrollController.offset).clamp(0, 40);
        n++;
      });
    });
  }

  List<Widget> _constructList() {
    var widgetList = <Widget>[];

    for (var i = 0; i < itemList.length; i++) {
      if (i % 5 == 0) {
        _headersMinExtent[i] = _headersMinExtent[i] ?? 40;

        widgetList.add(SliverPersistentHeader(
            pinned: true, delegate: HeaderDelegate(_headersMinExtent[i]!)));
      }
      widgetList.add(SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) => Container(
          decoration: BoxDecoration(
              color: Colors.yellow, border: Border.all(width: 0.5)),
          height: 30,
        ),
        childCount: 1,
      )));
    }
    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: _constructList(),
        ),
      ),
    );
  }
}

class HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _minExtent;
  HeaderDelegate(this._minExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration:
          BoxDecoration(color: Colors.green, border: Border.all(width: 0.5)),
    );
  }

  @override
  double get minExtent => _minExtent;

  @override
  double get maxExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class ListChildDelegate extends SliverChildDelegate {
  @override
  Widget? build(BuildContext context, int index) {
    throw UnimplementedError();
  }

  @override
  bool shouldRebuild(covariant SliverChildDelegate oldDelegate) => true;
}
