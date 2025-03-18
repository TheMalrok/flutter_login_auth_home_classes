import 'package:flutter/material.dart';

class ColorBox extends StatelessWidget {
  final Color color;
  final double? size;

  const ColorBox({super.key, required this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: size ?? 50,
      height: size ?? 50,
    );
  }
}
