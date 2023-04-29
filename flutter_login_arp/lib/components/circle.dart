import 'package:flutter/material.dart';

class CircleComponet extends StatelessWidget {
  final double size;
  final List<Color> colors;

  const CircleComponet(
      {super.key, this.size = 10.0, this.colors = Colors.accents});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: colors, begin: Alignment.center)),
    );
  }
}
