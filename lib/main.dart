import 'package:flutter/material.dart';

import '/some_words.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Random Flutter Words',
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff013795),
          foregroundColor: Colors.white,
        )),
        // A widget which will be started on application startup
        home: const SomeWords());
  }
}
