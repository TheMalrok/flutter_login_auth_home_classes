import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/person.dart';
import 'package:flutter_application_1/person_list.dart';

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
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 158, 98, 201),
                        ),
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
                        child: RadioListTile(
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
                        child: RadioListTile(
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
