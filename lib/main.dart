import 'dart:async';

import 'package:flutter/material.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'NanumSquareRound',
        primarySwatch: Colors.grey,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double elevation = 3.0;
  double size = 72.0;

  late AnimationController _controller;
  late Animation _animationH1;
  late Animation _animationH2;
  late Animation _animationM1;
  late Animation _animationM2;
  late Animation _animationS1;
  late Animation _animationS2;

  late Timer _timer;
  late DateTime _dateTime;

  int h1 = 0, h2 = 0, m1 = 0, m2 = 0, s1 = 0, s2 = 0;

  bool subH1 = false,
      subH2 = false,
      subM1 = false,
      subM2 = false,
      subS1 = false,
      subS2 = false;

  setTime(Timer timer) async {
    _dateTime = DateTime.now();

    subH1 = h1 != _dateTime.hour ~/ 10;
    subH2 = h2 != _dateTime.hour % 10;
    subM1 = m1 != _dateTime.minute ~/ 10;
    subM2 = m2 != _dateTime.minute % 10;
    subS1 = s1 != _dateTime.second ~/ 10;
    subS2 = s2 != _dateTime.second % 10;

    await _controller.forward();

    h1 = _dateTime.hour ~/ 10;
    h2 = _dateTime.hour % 10;
    m1 = _dateTime.minute ~/ 10;
    m2 = _dateTime.minute % 10;
    s1 = _dateTime.second ~/ 10;
    s2 = _dateTime.second % 10;

    await _controller.reverse();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    _animationH1 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.1,
        0.5,
        curve: Curves.easeInOut,
      ),
    );
    _animationH2 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.2,
        0.6,
        curve: Curves.easeInOut,
      ),
    );
    _animationM1 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.3,
        0.7,
        curve: Curves.easeInOut,
      ),
    );
    _animationM2 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.4,
        0.8,
        curve: Curves.easeInOut,
      ),
    );
    _animationS1 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.5,
        0.9,
        curve: Curves.easeInOut,
      ),
    );
    _animationS2 = CurvedAnimation(
      parent: _controller,
      curve: const Interval(
        0.7,
        1.0,
        curve: Curves.easeInOut,
      ),
    );
    /*
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _dateTime = DateTime.now();

        // h1 = _dateTime.hour ~/ 10;
        // h2 = _dateTime.hour % 10;
        // m1 = _dateTime.minute ~/ 10;
        // m2 = _dateTime.minute % 10;
      }
    });
    */

    _dateTime = DateTime.now();
    _timer = Timer.periodic(const Duration(milliseconds: 1000), setTime);

    h1 = _dateTime.hour ~/ 10;
    h2 = _dateTime.hour % 10;
    m1 = _dateTime.minute ~/ 10;
    m2 = _dateTime.minute % 10;
    s1 = _dateTime.second ~/ 10;
    s2 = _dateTime.second % 10;
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();

    super.dispose();
  }

  double min(double a, double b) => a > b ? b : a;

  @override
  Widget build(BuildContext context) {
    // double size = min(MediaQuery.of(context).size.width,
    //         MediaQuery.of(context).size.height) /
    //     10;
    double size = (MediaQuery.of(context).size.width - 64) / 4.8;
    elevation = size / 24;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return SizedBox(
                  width: size * 0.72,
                  height: size * 1.44,
                  child: Center(
                    child: Text(
                      "$h1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'NanumSquareRound',
                        fontWeight: FontWeight.w700,
                        fontSize: size,
                        color: Colors.grey.shade200,
                        shadows: [
                          Shadow(
                            color: Colors.grey.shade500.withOpacity(
                                subH1 ? 1.0 - _animationH1.value : 1.0),
                            offset: Offset(elevation, elevation) *
                                (subH1 ? 1.0 - _animationH1.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subH1 ? 1.0 - _animationH1.value : 1.0),
                          ),
                          Shadow(
                            color: Colors.white.withOpacity(
                                subH1 ? 1.0 - _animationH1.value : 1.0),
                            offset: Offset(-elevation, -elevation) *
                                (subH1 ? 1.0 - _animationH1.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subH1 ? 1.0 - _animationH1.value : 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return SizedBox(
                  width: size * 0.72,
                  height: size * 1.44,
                  child: Center(
                    child: Text(
                      "$h2",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'NanumSquareRound',
                        fontWeight: FontWeight.w700,
                        fontSize: size,
                        color: Colors.grey.shade200,
                        shadows: [
                          Shadow(
                            color: Colors.grey.shade500.withOpacity(
                                subH2 ? 1.0 - _animationH2.value : 1.0),
                            offset: Offset(elevation, elevation) *
                                (subH2 ? 1.0 - _animationH2.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subH2 ? 1.0 - _animationH2.value : 1.0),
                          ),
                          Shadow(
                            color: Colors.white.withOpacity(
                                subH2 ? 1.0 - _animationH2.value : 1.0),
                            offset: Offset(-elevation, -elevation) *
                                (subH2 ? 1.0 - _animationH2.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subH2 ? 1.0 - _animationH2.value : 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: size * 0.24),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return SizedBox(
                  width: size * 0.72,
                  height: size * 1.44,
                  child: Center(
                    child: Text(
                      "$m1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'NanumSquareRound',
                        fontWeight: FontWeight.w700,
                        fontSize: size,
                        color: Colors.grey.shade200,
                        shadows: [
                          Shadow(
                            color: Colors.grey.shade500.withOpacity(
                                subM1 ? 1.0 - _animationM1.value : 1.0),
                            offset: Offset(elevation, elevation) *
                                (subM1 ? 1.0 - _animationM1.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subM1 ? 1.0 - _animationM1.value : 1.0),
                          ),
                          Shadow(
                            color: Colors.white.withOpacity(
                                subM1 ? 1.0 - _animationM1.value : 1.0),
                            offset: Offset(-elevation, -elevation) *
                                (subM1 ? 1.0 - _animationM1.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subM1 ? 1.0 - _animationM1.value : 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return SizedBox(
                  width: size * 0.72,
                  height: size * 1.44,
                  child: Center(
                    child: Text(
                      "$m2",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'NanumSquareRound',
                        fontWeight: FontWeight.w700,
                        fontSize: size,
                        color: Colors.grey.shade200,
                        shadows: [
                          Shadow(
                            color: Colors.grey.shade500.withOpacity(
                                subM2 ? 1.0 - _animationM2.value : 1.0),
                            offset: Offset(elevation, elevation) *
                                (subM2 ? 1.0 - _animationM2.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subM2 ? 1.0 - _animationM2.value : 1.0),
                          ),
                          Shadow(
                            color: Colors.white.withOpacity(
                                subM2 ? 1.0 - _animationM2.value : 1.0),
                            offset: Offset(-elevation, -elevation) *
                                (subM2 ? 1.0 - _animationM2.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subM2 ? 1.0 - _animationM2.value : 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: size * 0.24),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return SizedBox(
                  width: size * 0.72,
                  height: size * 1.44,
                  child: Center(
                    child: Text(
                      "$s1",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'NanumSquareRound',
                        fontWeight: FontWeight.w700,
                        fontSize: size,
                        color: Colors.grey.shade200,
                        shadows: [
                          Shadow(
                            color: Colors.grey.shade500.withOpacity(
                                subS1 ? 1.0 - _animationS1.value : 1.0),
                            offset: Offset(elevation, elevation) *
                                (subS1 ? 1.0 - _animationS1.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subS1 ? 1.0 - _animationS1.value : 1.0),
                          ),
                          Shadow(
                            color: Colors.white.withOpacity(
                                subS1 ? 1.0 - _animationS1.value : 1.0),
                            offset: Offset(-elevation, -elevation) *
                                (subS1 ? 1.0 - _animationS1.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subS1 ? 1.0 - _animationS1.value : 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget? child) {
                return SizedBox(
                  width: size * 0.72,
                  height: size * 1.44,
                  child: Center(
                    child: Text(
                      "$s2",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'NanumSquareRound',
                        fontWeight: FontWeight.w700,
                        fontSize: size,
                        color: Colors.grey.shade200,
                        shadows: [
                          Shadow(
                            color: Colors.grey.shade500.withOpacity(
                                subS2 ? 1.0 - _animationS2.value : 1.0),
                            offset: Offset(elevation, elevation) *
                                (subS2 ? 1.0 - _animationS2.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subS2 ? 1.0 - _animationS2.value : 1.0),
                          ),
                          Shadow(
                            color: Colors.white.withOpacity(
                                subS2 ? 1.0 - _animationS2.value : 1.0),
                            offset: Offset(-elevation, -elevation) *
                                (subS2 ? 1.0 - _animationS2.value : 1.0),
                            blurRadius: elevation *
                                10 /
                                3 *
                                (subS2 ? 1.0 - _animationS2.value : 1.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
