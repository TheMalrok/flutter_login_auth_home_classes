class Person {
  String name;
  String surname;
  String? description;
  bool isTeacher;
  int? age;

  Person({
    required this.name,
    this.age,
    this.description,
    required this.isTeacher,
    required this.surname,
  });
}
