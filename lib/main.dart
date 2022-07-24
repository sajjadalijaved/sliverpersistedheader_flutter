import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SliverPersistentHeader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'SliverPersistentHeader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          stretch: true,
          title: Text(
            'Mountains',
            style: TextStyle(
              fontFamily: 'Allison',
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.deepPurple,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            stretchModes: [
              StretchMode.blurBackground,
              StretchMode.fadeTitle,
            ],
            centerTitle: true,
            title: Text(
              'Mountains',
              style: TextStyle(
                fontFamily: 'Allison',
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            background: Image(
              image: AssetImage('assets/mountains.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        ACustomSliverHeader(
          backgroundColor: Colors.amber,
          headerTitle: 'First Sliver Persistent Header Sample',
        ),
        ACustomSliverHeader(
          backgroundColor: Colors.green,
          headerTitle: 'Second Sliver Persistent Header Sample',
        ),
      ],
    ));
  }
}

class ACustomSliverHeader extends StatelessWidget {
  final Color backgroundColor;
  final String headerTitle;

  const ACustomSliverHeader({
    Key? key,
    required this.backgroundColor,
    required this.headerTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      floating: false,
      delegate: Delegate(backgroundColor, headerTitle),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final String headerTitle;

  Delegate(this.backgroundColor, this.headerTitle);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Text(
          headerTitle,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
