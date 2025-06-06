import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/person.dart';
import 'package:flutter_application_1/screens/person_screen.dart';

class Item extends StatelessWidget {
  final Person person;
  final VoidCallback onUpdate;
  final int index;

  const Item({
    super.key,
    required this.person,
    required this.onUpdate,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(
                  builder: (context) => PersonScreen(
                    person: person,
                    index: index,
                    onUpdate: onUpdate,
                  ),
                ),
              )
              .then((_) => onUpdate());
        },
        child: ListTile(
          leading: Hero(
            tag: "person_icon_${person.name}_${person.surname}",
            child: CircleAvatar(
                child: Icon(
                    person.isTeacher ? Icons.book : Icons.person_3_rounded)),
          ),
          title: Text('${person.name} ${person.surname}'),
          subtitle: Text(person.description ?? ''),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
