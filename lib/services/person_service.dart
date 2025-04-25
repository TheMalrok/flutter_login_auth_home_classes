import 'package:hive_ce/hive.dart';
import 'package:flutter_application_1/classes/person.dart';

class PersonService {
  static const String _boxName = 'persons';

  // Inicjalizacja Hive i otworzenie boxa
  static Future<Box<Person>> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<Person>(_boxName);
    }
    return Hive.box<Person>(_boxName);
  }

  // Pobieranie wszystkich osób
  static Future<List<Person>> getAllPersons() async {
    final box = await _openBox();
    return box.values.toList();
  }

  // Dodawanie nowej osoby
  static Future<void> addPerson(Person person) async {
    final box = await _openBox();
    await box.add(person);
  }

  // Aktualizacja osoby
  static Future<void> updatePerson(int index, Person person) async {
    final box = await _openBox();
    await box.putAt(index, person);
  }

  // Usuwanie osoby
  static Future<void> deletePerson(int index) async {
    final box = await _openBox();
    await box.deleteAt(index);
  }

  // Dodawanie przykładowych danych, jeśli box jest pusty
  static Future<void> addInitialData() async {
    final box = await _openBox();

    if (box.isEmpty) {
      await box.addAll([
        Person(
            name: 'Paweł',
            isTeacher: true,
            surname: 'Baraniak',
            description: 'Nauczyciel programowania aplikacji mobilnych',
            age: 30),
        Person(
            name: 'Kuba',
            isTeacher: false,
            surname: 'Marzęda',
            description: 'Programista flutter i pythona 50k miesięcznie'),
        Person(
          name: 'Agnieszka',
          isTeacher: false,
          surname: 'Płudowska',
        ),
        Person(
            name: "Tomek",
            surname: "Gziut",
            isTeacher: false,
            age: 18,
            description: "kurdelek felek"),
        Person(
            name: "Laura",
            surname: "Strycharczuk",
            isTeacher: false,
            description: "nie wiem",
            age: 44),
        Person(
            name: "Patryk",
            isTeacher: true,
            surname: "Grzyb",
            description: "charyzmatyczny, piękny, skromy"),
        Person(
            name: "Aleks",
            isTeacher: false,
            surname: "Szlapa",
            description: "AAAAAAAAAAAAAAAAAAAAAAAAAAAAA"),
        Person(
          name: "Antoni",
          isTeacher: false,
          surname: "Smaga",
          description: "COS",
        ),
        Person(
            name: "Mikolaj",
            isTeacher: true,
            surname: "Lawecki",
            description: "Sigma"),
      ]);
    }
  }
}
