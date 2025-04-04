import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/person.dart';
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
                  child: Item(person: personList[index]));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 158, 98, 201),
        onPressed: () => showAddPersonSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showAddPersonSheet(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();
    TextEditingController isTeacherController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: <Widget>[
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  TextField(
                    controller: surnameController,
                    decoration: InputDecoration(
                      hintText: 'Surname',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  TextField(
                    controller: isTeacherController,
                    decoration: InputDecoration(
                      hintText: 'isTeacher',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      hintText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: const Text('Add Person'),
                    onPressed: () => setState(() {
                      _addPerson(
                        name: nameController.text,
                        surname: surnameController.text,
                        isTeacher: isTeacherController.text,
                        age: ageController.text,
                        description: descriptionController.text,
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _addPerson(
      {String? name,
      String? surname,
      String? isTeacher,
      String? age,
      String? description}) {
    personList.add(Person(
      name: name ?? "",
      surname: surname ?? "",
      isTeacher: isTeacher == "true",
      age: int.tryParse(age ?? ""),
      description: description,
    ));
  }
}

_goToSetttingsScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
}
