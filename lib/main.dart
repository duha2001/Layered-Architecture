import 'package:flutter/material.dart';
import 'package:layered_architecture/presentation/home_page.dart';
import 'package:layered_architecture/service_locator.dart';


void main() {
  setupMainDeps();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: '$HomePage',
      routes: {
        '$HomePage': (_) => const HomePage(),
      },
    );
  }
}


