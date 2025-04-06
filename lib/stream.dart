import 'package:flutter/material.dart';

class ColorStream {

  final List<Color> colors = [
    Colors.cyanAccent,
    Colors.lime,
    Colors.blueAccent,
    Colors.yellowAccent,
    Colors.tealAccent,
  ];

  Stream<Color> getColors() async* {
    yield* Stream.periodic(
      const Duration(seconds: 1), (int t) {
        int index = t % colors.length;
        return colors[index];
      });
  }
}