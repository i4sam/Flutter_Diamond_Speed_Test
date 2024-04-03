import 'dart:async';
import 'package:flutter/material.dart';

class DynamicDotsWidget extends StatefulWidget {
  const DynamicDotsWidget({
    Key? key,
    this.dotCount = 3,
    this.dotInterval = 500,
  }) : super(key: key);

  final int dotCount;
  final int dotInterval;

  @override
  _DynamicDotsWidgetState createState() => _DynamicDotsWidgetState();
}

class _DynamicDotsWidgetState extends State<DynamicDotsWidget> {
  late Timer _timer;
  int _currentDotCount = 0;

  @override
  void initState() {
    super.initState();
    _timer =
        Timer.periodic(Duration(milliseconds: widget.dotInterval), (timer) {
      setState(() {
        _currentDotCount = (_currentDotCount + 1) % (widget.dotCount + 1);
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dots = List.generate(_currentDotCount, (index) => '.').join();
    return Text(
      ' $dots ',
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
