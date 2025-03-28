import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/person.dart';

class Item extends StatelessWidget {
  final Person person;
  const Item({
    super.key,
    required this.person,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
            child: Icon(person.isTeacher
                ? Icons.account_balance
                : Icons.person_3_rounded)),
        title: Text('${person.name} ${person.surname}'),
        subtitle: Text(person.description ?? ''),
        trailing: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}
