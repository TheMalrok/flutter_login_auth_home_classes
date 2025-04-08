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

  Future<void> showAddPersonSheet(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController surnameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    String? isTeacher;

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    SizedBox(height: 12),
                    TextField(
                      controller: surnameController,
                      decoration: InputDecoration(
                        hintText: 'Surname',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Teacher'),
                            value: 'isTeacher',
                            groupValue: isTeacher,
                            onChanged: (String? value) {
                              setState(() {
                                isTeacher = value;
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: RadioListTile<String>(
                            title: const Text('Student'),
                            value: 'isStudent',
                            groupValue: isTeacher,
                            onChanged: (String? value) {
                              setState(() {
                                isTeacher = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Age',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: const Text('Add Person'),
                      onPressed: () {
                        setState(() {
                          _addPerson(
                            name: nameController.text,
                            surname: surnameController.text,
                            isTeacher: isTeacher,
                            age: ageController.text,
                            description: descriptionController.text,
                          );
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
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
      isTeacher: isTeacher == isTeacher ? true : false,
      age: int.tryParse(age ?? ""),
      description: description,
    ));
  }
}

_goToSetttingsScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
}
