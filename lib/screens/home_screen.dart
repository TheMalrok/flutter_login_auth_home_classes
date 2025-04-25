import 'package:flutter/material.dart';
import 'package:flutter_application_1/classes/person.dart';
import 'package:flutter_application_1/screens/settings_screen.dart';
import 'package:flutter_application_1/services/person_service.dart';
import 'package:flutter_application_1/widgets/bottom_sheet.dart';
import 'package:flutter_application_1/widgets/item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Person> _personList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPersons();
  }

  Future<void> _loadPersons() async {
    setState(() {
      _isLoading = true;
    });

    final persons = await PersonService.getAllPersons();

    setState(() {
      _personList = persons;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
              onPressed: () => _goToSetttingsScreen(context),
              icon: Icon(Icons.settings))
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          const Color.fromARGB(255, 166, 0, 255),
          const Color.fromARGB(255, 26, 0, 50),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  final persons = await PersonService.getAllPersons();
                  setState(() {
                    _personList = persons..shuffle();
                  });
                },
                child: _personList.isEmpty
                    ? Center(
                        child: Text(
                          'Brak osób do wyświetlenia',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _personList.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Używamy klucza opartego na unikalnej wartości (kombinacja imienia i nazwiska)
                          // co jest lepsze niż używanie indeksu, który może się zmieniać
                          return Dismissible(
                            key: Key(
                                '${_personList[index].name}_${_personList[index].surname}_${index}'),
                            background: Container(
                              color: Theme.of(context).colorScheme.primary,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child:
                                  const Icon(Icons.delete, color: Colors.white),
                            ),
                            direction:
                                DismissDirection.endToStart, // Tylko w prawo
                            confirmDismiss: (direction) async {
                              // Zapisujemy do zmiennej, żeby uniknąć problemów z indeksem
                              final personToDelete = _personList[index];
                              final indexToDelete = index;

                              return await showDialog<bool>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title:
                                            const Text('Potwierdź usunięcie'),
                                        content: Text(
                                            'Czy chcesz usunąć ${personToDelete.name} ${personToDelete.surname}?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            child: const Text('Anuluj'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            child: const Text('Usuń'),
                                          ),
                                        ],
                                      );
                                    },
                                  ) ??
                                  false; // Na wszelki wypadek, jeśli dialog zostanie zamknięty w inny sposób
                            },
                            onDismissed: (direction) {
                              // Użycie copy, żeby uniknąć problemów z indeksem po usunięciu
                              final indexToDelete = index;

                              // Najpierw aktualizujemy stan, aby widget zniknął natychmiast
                              setState(() {
                                _personList.removeAt(indexToDelete);
                              });

                              // Następnie wykonujemy operację usuwania w bazie danych
                              PersonService.deletePerson(indexToDelete)
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Osoba została usunięta')),
                                );
                              });
                            },
                            child: Item(
                              person: _personList[index],
                              onUpdate: () => _loadPersons(),
                              index: index,
                            ),
                          );
                        },
                      ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: const Color.fromARGB(255, 158, 98, 201),
        onPressed: () =>
            showAddPersonSheet(context).then((_) => _loadPersons()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

_goToSetttingsScreen(BuildContext context) {
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => const SettingsScreen()));
}
