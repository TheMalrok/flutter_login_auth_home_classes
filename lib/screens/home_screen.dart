import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
              onPressed: () => _goToSetttingsScreen(context),
              icon: Icon(Icons.settings))
        ],
      ),
      body: Center(child: Text('Home Screen')),
    );
  }
}

_goToSetttingsScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
}
