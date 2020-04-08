import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({this.title});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _big0 = false;
  bool _big1 = false;
  bool _big2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          IndexedStack(
              index: 0,
//            direction: Axis.vertical,
//        crossAxisAlignment: WrapCrossAlignment.center,
//        runAlignment: WrapAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyHeroTest()));
                  },
                  child: Container(
                      height: 100,
                      width: 100,
                      child: Hero(tag: 'myCat',child: Image.asset('assets/cat_1.png'))),
                ),]),
          IndexedStack(
            index: 0,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    this._big0 = !this._big0;
                    if (this._big0) {
                      this._big1 = false;
                      this._big2 = false;
                    }
                  });
                },
                child: AnimatedContainer(
                    transform: Matrix4.rotationZ((_big0 ? 50 : 0)),
                    duration: Duration(milliseconds: 800),
                    height: (_big0 ? 500 : 100),
                    width: (_big0 ? 500 : 100),
                    curve: (_big0 ? Curves.ease : Curves.bounceOut),
                    child: Image.asset('assets/cat_1.png')),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                this._big1 = !this._big1;
                if (this._big1) {
                  this._big2 = false;
                  this._big0 = false;
                }
              });
            },
            child: AnimatedContainer(
                transform: Matrix4.rotationZ((_big1 ? 50 : 0)),
                duration: Duration(milliseconds: 800),
                height: (_big1 ? 500 : 100),
                width: (_big1 ? 500 : 100),
                curve: (_big1 ? Curves.ease : Curves.bounceOut),
                child: Image.asset('assets/cat_1.png')),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                this._big2 = !this._big2;
                if (this._big2) {
                  this._big0 = false;
                  this._big1 = false;
                }
              });
            },
            child: AnimatedContainer(
                transform: Matrix4.rotationZ((_big2 ? 50 : 0)),
                duration: Duration(milliseconds: 800),
                height: (_big2 ? 500 : 100),
                width: (_big2 ? 500 : 100),
                curve: (_big2 ? Curves.ease : Curves.bounceOut),
                child: Image.asset('assets/cat_1.png')),
          )

//          MaterialButton(
//            color: Theme.of(context).primaryColor,
//            child: Text(
//              (_big ? "Make Small" : "Make big"),
//            ),
//            onPressed: () {
//              setState(() {
//                this._big = !this._big;
//              });
//            },
//          ),
        ],
      ),
    );
  }
}

class MyHeroTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          child: Hero(
              tag: 'myCat',
              child: Image.asset(
                'assets/cat_1.png',
                height: 500,
                width: 500,
              ))),
    );
  }
}

MaterialApp getTest1App(){
  return MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is not restarted.
      primarySwatch: Colors.blue,
    ),
    home: MyHomePage(title: 'Flutter Demo Home Page'),
  );
}