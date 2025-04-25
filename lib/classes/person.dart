// lib/classes/person.dart
import 'package:hive_ce/hive.dart';

part 'person.g.dart';

@HiveType(typeId: 1)
class Person {
  @HiveField(0)
  String name;

  @HiveField(1)
  String surname;

  @HiveField(2)
  String? description;

  @HiveField(3)
  bool isTeacher;

  @HiveField(4)
  int? age;

  Person({
    required this.name,
    this.age,
    this.description,
    required this.isTeacher,
    required this.surname,
  });
}
