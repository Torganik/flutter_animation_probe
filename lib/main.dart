import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //return  getTest1App();
    // return TestApp2();
    return TestApp3();
  }
}

class TestApp3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (BuildContext context) {
          return MyTestApp3( MediaQuery
              .of(context)
              .size);
        }));
  }
}

class MyTestApp3 extends StatefulWidget {
  Size _screenSize;
  MyTestApp3(this._screenSize);
  @override
  _MyTestApp3State createState() => _MyTestApp3State(_screenSize);
}

class _MyTestApp3State extends State<MyTestApp3> {
  final Size _screenSize;
  _MyTestApp3State(this._screenSize);

  List<Color> _colors = [
    Color.fromRGBO(0xed, 0x5b, 0x1e, 1),
    Color.fromRGBO(0x1b, 0x0e, 0x28, 1)
  ];

  List<double> _stops = [0.0, 0.7];

  final double _sunStart = 330;
  final double _sunStartLeft = 250;
  final int _duration = 30;
  final int cloudDuration = 30;
  double _sunBottom = 330;
  double _sunLeft = 250;
  Color _bgColor = Color.fromRGBO(0xed, 0x5b, 0x1e, 1);

  double _sunSizeHW = 300;
  double _sunSizeHWSmall = 150;
  double _sunSize = 150;

  void _startAnimation() {
    setState(() {
      _sunBottom = -300.0;
      _sunLeft = -350.0;
      _bgColor = Color.fromRGBO(0x1b, 0x0e, 0x28, 1);
      _sunSize = _sunSizeHW;
      cloudLeft1*=cloudDuration/5;
      cloudLeft2*=cloudDuration/5;
      cloudLeft3*=cloudDuration/5;
    });
  }

  void _returnToStart() {
    setState(() {
      _sunBottom = _sunStart;
      _sunLeft = _sunStartLeft;
      _bgColor = Color.fromRGBO(0xed, 0x5b, 0x1e, 1);
      _sunSize = _sunSizeHWSmall;
      cloudLeft1/=cloudDuration/5;
      cloudLeft2/=cloudDuration/5;
      cloudLeft3/=cloudDuration/5;
    });
  }

  double _generateTopCloud() {
    Random rnd = Random();
    num newTop = rnd.nextInt(_screenSize.height ~/ 3);
    newTop = max(70, newTop);

    return newTop / 1.0;
  }

  double _generateLeftCloud() {
    Random rnd = Random();
    num newTop = rnd.nextInt(_screenSize.width/2 ~/ 1);
    newTop = max(0, newTop);

    return newTop / 1.0;
  }

  double cloudTop1;
  double cloudTop2;
  double cloudTop3;
  double cloudLeft1;
  double cloudLeft2;
  double cloudLeft3;

  @override
  void initState() {
    super.initState();
    cloudTop1 = _generateTopCloud();
    cloudTop2 = _generateTopCloud();
    cloudTop3 = _generateTopCloud();
    cloudLeft1 = _generateLeftCloud();
    cloudLeft2 = _generateLeftCloud();
    cloudLeft3 = _generateLeftCloud();
  }

  @override
  Widget build(BuildContext context) {

    return Stack(children: <Widget>[
      AnimatedContainer(
        duration: Duration(seconds: _duration),
        height: _screenSize.height,
        width: _screenSize.width,
        color: _bgColor,
      ),
      AnimatedPositioned(
        duration: Duration(seconds: cloudDuration),
        top: cloudTop1,
        left: cloudLeft3,
        child: Cloud(3),
      ),
      AnimatedPositioned(
        duration: Duration(seconds: cloudDuration),
        top: cloudTop2,
        left: cloudLeft1,
        child: Cloud(1),
      ),
      AnimatedPositioned(
        duration: Duration(seconds: cloudDuration),
        top: cloudTop3,
        left: cloudLeft2,
        child: Cloud(2),
      ),
      AnimatedPositioned(
        duration: Duration(seconds: _duration),
        bottom: _sunBottom,
        left: _sunLeft,
        child: GestureDetector(
            onDoubleTap: _returnToStart,
            onTap: _startAnimation,
            child: AnimatedContainer(
                height: _sunSize,
                width: _sunSize,
                duration: Duration(seconds: _duration),
                child: Sun(Size(_sunSize, _sunSize)))),
      ),
      Positioned(
        bottom: -160,
        right: -110,
        child: Transform.rotate(
          angle: 6.1,
          child: Container(
            height: 300,
            width: _screenSize.width,
            color: Color.fromRGBO(0x84, 0x3f, 0x1c, 1),
          ),
        ),
      ),
      Positioned(
        bottom: -160,
        left: -120,
        child: Transform.rotate(
          angle: 0.22,
          child: Container(
            height: 300,
            width: _screenSize.width * 1.5,
            color: Color.fromRGBO(0x33, 0x33, 0x33, 1),
          ),
        ),
      ),

      Positioned(
        bottom: 150,
        left: _screenSize.width / 4,
        child: Container(
          color: Colors.transparent,
          child: Cactus(),
        ),
      ),
      Positioned(
        bottom: 80,
        right: _screenSize.width / 6,
        child: Container(
          color: Colors.transparent,
          child: GestureDetector(onDoubleTap: _returnToStart, child: Cactus2()),
        ),
      )
    ]);
  }
}

class Sun extends StatelessWidget {
  final Size sz;

  Sun(this.sz);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: sz,
      painter: SunPainter(),
    );
  }
}

class SunPainter extends CustomPainter {
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.height, size.width) / 2;
    final center = Offset(size.height / 2, size.width / 2);
    final paint = Paint()
      ..color = Colors.yellow;
    Color color1 = Color.fromRGBO(
        Colors.yellow.red, Colors.yellow.green, Colors.yellow.blue, 0.8);
    Color color2 = Color.fromRGBO(
        Colors.yellow.red, Colors.yellow.green, Colors.yellow.blue, 0.6);
    Color color3 = Color.fromRGBO(
        Colors.yellow.red, Colors.yellow.green, Colors.yellow.blue, 0.4);

    final paintShine1 = Paint()
      ..color = color1;
    final paintShine2 = Paint()
      ..color = color2;
    final paintShine3 = Paint()
      ..color = color3;

    canvas.drawCircle(center, radius * 1.8, paintShine3);
    canvas.drawCircle(center, radius * 1.444, paintShine2);
    canvas.drawCircle(center, radius * 1.2222, paintShine1);
    canvas.drawCircle(center, radius, paint);
  }
}

class Cactus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 150),
      painter: CactusPainter(),
    );
  }
}

class Cactus2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(100, 150),
      painter: Cactus2Painter(),
    );
  }
}

class CactusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double lineWidth = 15;
    final paint = Paint()
      ..color = Color.fromRGBO(0x33, 0x33, 0x33, 1)
      ..strokeWidth = lineWidth;
    //final paint = Paint()..color =  Colors.yellow ..strokeWidth = lineWidth;

    // Left part
    final leftOffset = Offset(lineWidth, size.height / 3);
    canvas.drawLine(leftOffset, Offset(lineWidth, size.height / 1.4), paint);
    canvas.drawLine(Offset(lineWidth, size.height / 1.4),
        Offset(lineWidth + (size.height / 5), size.height / 1.4), paint);

    canvas.drawCircle(leftOffset, 7, paint);
    canvas.drawCircle(Offset(lineWidth, size.height / 1.4), 7, paint);

    // Right
    canvas.drawLine(Offset(size.width / 2, size.height / 1.6),
        Offset(size.width / 2 + size.width / 4, size.height / 1.6), paint);
    canvas.drawLine(Offset(size.width / 2 + size.width / 4, size.height / 1.6),
        Offset(size.width / 2 + size.width / 4, size.height / 2.5), paint);

    canvas.drawCircle(
        Offset(size.width / 2 + size.width / 4, size.height / 1.6), 7, paint);
    canvas.drawCircle(
        Offset(size.width / 2 + size.width / 4, size.height / 2.5), 7, paint);

    // Middle
    canvas.drawLine(Offset(45, lineWidth), Offset(45, size.height*1.2), paint);
    canvas.drawCircle(Offset(45, 15), 7, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Cactus2Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double lineWidth = 12;
    final paint = Paint()
      ..color = Color.fromRGBO(0x33, 0x33, 0x33, 1)
      ..strokeWidth = lineWidth;
    //final paint = Paint()..color =  Colors.yellow ..strokeWidth = lineWidth;

    // Left part
    final leftOffset = Offset(lineWidth * 2.2, size.width / 4);
    canvas.drawLine(
        leftOffset, Offset(lineWidth * 1.9, size.height / 2.2), paint);
    canvas.drawLine(Offset(lineWidth * 1.9, size.height / 2.2),
        Offset(lineWidth + (size.height / 4), size.height / 2.2), paint);

    canvas.drawCircle(leftOffset, lineWidth / 2, paint);
    canvas.drawCircle(
        Offset(lineWidth * 1.9, size.height / 2.2), lineWidth / 2, paint);

    // Right
    canvas.drawLine(Offset(size.width / 2, size.height / 1.6),
        Offset(size.width / 2 + size.width / 4, size.height / 1.6), paint);
    canvas.drawLine(Offset(size.width / 2 + size.width / 4, size.height / 1.6),
        Offset(size.width / 2 + size.width / 4, size.height / 2.5), paint);

    canvas.drawCircle(
        Offset(size.width / 2 + size.width / 4, size.height / 1.6),
        lineWidth / 2,
        paint);
    canvas.drawCircle(
        Offset(size.width / 2 + size.width / 4, size.height / 2.5),
        lineWidth / 2,
        paint);

    // Middle
    canvas.drawLine(Offset(size.width / 2, lineWidth),
        Offset(size.width / 2, size.height / 1.2), paint);
    canvas.drawCircle(Offset(size.width / 2, lineWidth), lineWidth / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Cloud extends StatelessWidget {
  final int _cloudType;

  Cloud(this._cloudType);

  CustomPainter _getPainter() {
    CustomPainter result;
    switch (_cloudType) {
      case 1:
        {
          result = CloudTypeOnePainter();
          break;
        }
      case 2:
        {
          result = CloudTypeTwosPainter();
          break;
        }
      case 3:
        {
          result = CloudTypeThreesPainter();
          break;
        }
      default:
        {
          result = CloudTypeOnePainter();
        }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    CustomPainter cp = _getPainter();
    return Opacity(
      opacity:0.65555,
      child: Container(
        child: CustomPaint(
          size: Size(100, 50),
          painter: cp,
        ),
      ),
    );
  }
}

class CloudTypeOnePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final double _lineWidth = 30;
    final Color _whiteCloud = Color.fromRGBO(0xFF, 0xFF, 0xFF, 1);
    final Paint paint = Paint()
      ..color = _whiteCloud
      ..strokeWidth = _lineWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(_lineWidth * 2, -_lineWidth + 10),
        Offset(size.width + 20, -_lineWidth + 10), paint);
    canvas.drawLine(Offset(0, 0), Offset(size.width * 1.5, 0), paint);
    canvas.drawLine(
        Offset(30, _lineWidth - 10), Offset(size.width, _lineWidth - 10),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CloudTypeTwosPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final double _lineWidth = 30;
    final Color _whiteCloud = Color.fromRGBO(0xFF, 0xFF, 0xFF, 1);
    final Paint paint = Paint()
      ..color = _whiteCloud
      ..strokeWidth = _lineWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, 0), Offset(size.width * 1.5, 0), paint);
    canvas.drawLine(
        Offset(-30, _lineWidth - 10), Offset(size.width - 30, _lineWidth - 10),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class CloudTypeThreesPainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final double _lineWidth = 30;
    final Color _whiteCloud = Color.fromRGBO(0xFF, 0xFF, 0xFF, 1);
    final Paint paint = Paint()
      ..color = _whiteCloud
      ..strokeWidth = _lineWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(Offset(0, 0), Offset(size.width * 1.2, 0), paint);
    canvas.drawLine(
        Offset(30, _lineWidth - 50), Offset(size.width - 10, _lineWidth - 50),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

