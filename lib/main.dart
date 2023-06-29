import 'package:flutter/material.dart';
import 'package:todoapp/screen/mainscr.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(240, 9, 42, 90), //,
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(240, 9, 42, 90),
            shadowColor: Colors.transparent),
      ),
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData.dark(),
      home: const MainScreen(),
    );
  }

}



































//https://api.nstack.in/
//dkmkxm