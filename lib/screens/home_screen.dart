import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/person.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
import 'package:flutter_application_1/person_list.dart';
import 'package:flutter_application_1/widgets/bottom_sheet.dart';
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
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          const Color.fromARGB(255, 166, 0, 255),
          const Color.fromARGB(255, 26, 0, 50),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: RefreshIndicator(
          onRefresh: () {
            setState(() {
              personList.shuffle();
            });
            return Future.value(true);
          },
          child: ListView.builder(
            itemCount: personList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(index.toString()),
                child: Item(
                  person: personList[index],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 158, 98, 201),
        onPressed: () =>
            showAddPersonSheet(context).whenComplete(() => setState(() {})),
        child: const Icon(Icons.add),
      ),
    );
  }
}

_goToSetttingsScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
}
