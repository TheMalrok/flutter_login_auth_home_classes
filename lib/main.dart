import 'package:flutter/material.dart';
import 'package:flutter_application_1/customization/themes.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_ce/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_application_1/classes/person.dart';
import 'package:flutter_application_1/services/person_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicjalizacja Hive dla hive_ce
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  // Rejestracja adapterów
  Hive.registerAdapter(PersonAdapter());

  // Dodanie przykładowych danych (jeśli box jest pusty)
  await PersonService.addInitialData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemes.lightTheme,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: FutureBuilder<bool>(
        future: _isLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return snapshot.data == true
              ? const HomeScreen()
              : const LoginScreen();
        },
      ),
    );
  }
}

Future<bool> _isLoggedIn() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  // Get logged status, or default to false if not found
  return prefs.getBool('logged') ?? false;
}
