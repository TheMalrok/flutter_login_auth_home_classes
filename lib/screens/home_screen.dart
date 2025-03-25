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
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text('Pawel Baraniak'),
              subtitle: Text('Nauczyciel programowania aplikacji mobilnych'),
              leading: CircleAvatar(
                child: Icon(Icons.account_circle_outlined),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          )
        ],
      ),
    );
  }
}

_goToSetttingsScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
}
