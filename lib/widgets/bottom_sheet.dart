import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/person.dart';
import 'package:flutter_application_1/services/person_service.dart';

Future<void> showAddPersonSheet(BuildContext context) {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? isTeacher;

  String? nameError;
  String? surnameError;
  String? radioError;

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
                      errorText: nameError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(255, 158, 98, 201),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      if (nameError != null) {
                        setState(() {
                          nameError = null;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: surnameController,
                    decoration: InputDecoration(
                      hintText: 'Surname',
                      errorText: surnameError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      if (surnameError != null) {
                        setState(() {
                          surnameError = null;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  radioError = null;
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
                                  radioError = null;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      if (radioError != null)
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0),
                          child: Text(
                            radioError!,
                            style: TextStyle(color: Colors.red, fontSize: 12),
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
                    onPressed: () async {
                      // Walidacja przed dodaniem osoby
                      bool isValid = true;

                      if (nameController.text.trim().isEmpty) {
                        setState(() {
                          nameError = 'Imię jest wymagane';
                        });
                        isValid = false;
                      }

                      if (surnameController.text.trim().isEmpty) {
                        setState(() {
                          surnameError = 'Nazwisko jest wymagane';
                        });
                        isValid = false;
                      }

                      if (isTeacher == null) {
                        setState(() {
                          radioError = 'Wybierz rolę (nauczyciel lub uczeń)';
                        });
                        isValid = false;
                      }

                      if (isValid) {
                        // Tworzenie nowej osoby
                        final newPerson = Person(
                          name: nameController.text,
                          surname: surnameController.text,
                          isTeacher: isTeacher == 'isTeacher',
                          age: int.tryParse(ageController.text),
                          description: descriptionController.text.isEmpty
                              ? null
                              : descriptionController.text,
                        );

                        // Zapisanie do Hive
                        await PersonService.addPerson(newPerson);

                        // Zamknięcie bottom sheet
                        Navigator.pop(context);

                        // Komunikat o sukcesie
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Osoba została dodana'),
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }
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
