import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class TestApp2 extends StatefulWidget {
  @override
  _TestApp2State createState() => _TestApp2State();
}

class _TestApp2State extends State<TestApp2> {
  int _top = 0;
  int _bottom = 0;
  double _drag = 100.0;
  double _rad = 50.0;
  double _posLeft = 25.0;
  double _posTop = 50.0;
  void onHorizonalDrag(DragStartDetails dsd){
    print(dsd.localPosition);
  }

  void onHorizonalDragUpdate(DragUpdateDetails dud){
    print(dud.globalPosition);
    var _newDrag =  350 - dud.globalPosition.dx ;
    if(_newDrag<100){
      _newDrag = 100;
    }
    setState(() {
      _drag = _newDrag.roundToDouble();
    });

  }

  void changeBottom(){
    setState(() {
      if(_bottom == 0){
        _bottom = 300;
      }else{
        _bottom = 0;
      }
    });
  }

  void changeTop() {
    setState(() {
      if (_top == 0) {
        _top = 50;
      } else {
        _top = 0;
      }
    });
  }

  void onHorizonalDragUpdateCircle(DragUpdateDetails dud){
    _posLeft = dud.globalPosition.dx - 75.0;
    _posTop = dud.globalPosition.dy- 75.0;

    setState(() {

    });
  }

  List<BoxShadow> getPickGlowing() {
    return [
      BoxShadow(color: Colors.orangeAccent, spreadRadius: 5, blurRadius: 8)
    ];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: Stack(
        children: <Widget>[
          Positioned(
            left: _posLeft,
            top: _posTop,
            child: GestureDetector(
              onHorizontalDragUpdate: onHorizonalDragUpdateCircle,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                    Border.all(width: 7.0, color: const Color(0xFFFFFFFF)),
                    color: Colors.transparent),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 50,
            child: GestureDetector(
              onHorizontalDragUpdate: onHorizonalDragUpdate,
              onHorizontalDragStart: onHorizonalDrag,
              child: Container(
                width: 1.0 *_drag,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(_rad))
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 1),
            left: 30,
            top: 250.0 + _top *7  ,
            curve: Curves.bounceOut,
            child: GestureDetector(
              onTap: changeTop,
              child: Container(
                width: 250,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(seconds: 2),
            curve: Curves.ease,
            bottom: double.parse(_bottom.toString()),
            left: double.parse(_bottom.toString()),
            child: GestureDetector(
              onTap: changeBottom,
              child: Container(
                color: Colors.transparent,
                child: CustomPaint(
                  painter: MyPainter(),
                  size: Size(100, 100),

                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MyPainter extends CustomPainter {

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width)/2;
    final center = Offset(size.height/2, size.width/2);
    final paint = Paint()..color = Colors.yellow;

    canvas.drawCircle(center, radius, paint);


//    Paint p = Paint();
//    p.color = Colors.white;
//    p.style = PaintingStyle.stroke;
//    p.strokeWidth = 10;
//    canvas.drawLine(Offset.zero, Offset(11,10), p);
  }
}