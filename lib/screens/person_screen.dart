import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/person.dart';

class PersonScreen extends StatelessWidget {
  final Person person;
  const PersonScreen({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(person.name),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50,
                child: Icon(person.isTeacher
                    ? Icons.account_balance
                    : Icons.person_3_rounded),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${person.name} ${person.surname}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                person.description ?? '',
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ));
  }
}
