import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/color_box.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ColorBox(color: Colors.black, size: 100),
      ),
    );
  }
}
