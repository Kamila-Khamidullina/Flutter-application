import 'package:flutter/material.dart';
import 'package:hw/app.dart';

void main() => runApp(const JsonWidget());

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(home: JsonWidget());
}
