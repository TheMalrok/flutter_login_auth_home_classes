import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
import 'package:flutter_application_1/person_list.dart';
import 'package:flutter_application_1/widgets/item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            personList.shuffle();
          });
          return Future.value(true);
        },
        child: ListView.builder(
          itemCount: personList.length,
          itemBuilder: (BuildContext context, int index) {
            return Item(person: personList[index]);
          },
        ),
      ),
    );
  }
}

_goToSetttingsScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
}
