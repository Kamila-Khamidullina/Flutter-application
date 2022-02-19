import 'package:flutter/material.dart';
import 'package:hw/app.dart';
import 'package:hw/bootom.dart';

void main() => runApp(const MyHomePage());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(home: JsonWidget());
}
