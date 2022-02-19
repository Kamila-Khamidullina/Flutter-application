import 'package:flutter/material.dart';
import 'package:hw/query.dart';
import 'app.dart';
import 'random.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  Widget Categories = const JsonWidget();
  Widget Random = RandomJoke();
  Widget Query = QueryForm(responce: '');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: getBody(),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: const Color.fromARGB(255, 69, 31, 112),
            unselectedItemColor: const Color.fromARGB(255, 188, 174, 248),
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.toc),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cached),
                label: "Random",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.public),
                label: "Query",
              )
            ],
            onTap: (int index) {
              onTapHandler(index);
            },
          ),
        ));
  }

  Widget getBody() {
    if (selectedIndex == 0) {
      return Categories;
    } else if (selectedIndex == 1) {
      return Random;
    } else {
      return Query;
    }
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
