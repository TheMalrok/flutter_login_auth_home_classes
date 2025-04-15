import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/person.dart';

class PersonScreen extends StatefulWidget {
  final Person person;
  const PersonScreen({
    super.key,
    required this.person,
  });

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  @override
  Widget build(BuildContext context) {
    var _textEditingController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.person.name),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            const Color.fromARGB(255, 166, 0, 255),
            const Color.fromARGB(255, 26, 0, 50),
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Hero(
                    tag:
                        "person_icon_${widget.person.name}_${widget.person.surname}",
                    child: CircleAvatar(
                      radius: 50,
                      child: Icon(widget.person.isTeacher
                          ? Icons.book
                          : Icons.person_3_rounded),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.person.name} ${widget.person.surname}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.person.description ?? '',
                    style: const TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      // Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Potwierdź'),
                            content: const Text('Czy chcesz zapisać zmiany?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Anuluj'),
                              ),
                              TextButton(
                                onPressed: () {
                                  widget.person.description =
                                      _textEditingController.text;
                                  _textEditingController.clear();
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Potwierdź'),
                              ),
                            ],
                          );
                        },
                      );
                      // Clear the text field
                    });
                  },
                  child: const Text('Save'),
                ),
              ],
            ),
          ),
        ));
  }
}
