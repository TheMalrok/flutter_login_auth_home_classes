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
                      widget.person.description = _textEditingController.text;
                    });
                  },
                  child: const Text('Save'),
                ),
                Image.network(
                  'https://i.ytimg.com/vi/TwlT0Ph9WKE/hq720.jpg?sqp=-oaymwE7CK4FEIIDSFryq4qpAy0IARUAAAAAGAElAADIQj0AgKJD8AEB-AHUBoAC4AOKAgwIABABGHIgXShGMA8=&rs=AOn4CLCi2d_iZCUpS3SspAweKWkEelnepg',
                )
              ],
            ),
          ),
        ));
  }
}
