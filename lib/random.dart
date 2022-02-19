import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import "dart:math";
import 'app.dart';

const _baseUrl = 'https://api.chucknorris.io/jokes/random?category=';
String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

Future<Map<String, Object?>> fetchJoke(url) async {
  final response = await get(Uri.parse(url));
  return jsonDecode(response.body) as Map<String, Object?>;
}

class RandomJoke extends StatelessWidget {
  const RandomJoke({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _random = Random();
    var category = categories[_random.nextInt(categories.length)];
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "ChukNorrisJokes",
        home: Scaffold(
            appBar: AppBar(
              title: const Text('Jokes'),
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 69, 31, 112),
              shadowColor: const Color.fromARGB(255, 41, 1, 87),
              actions: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                    child: IconButton(
                      icon: const Icon(Icons.error),
                      onPressed: () {
                        showAboutDialog(
                            context: context,
                            applicationName: 'CN jokes',
                            applicationIcon: Image.asset(
                                'assets\\images\\logo.png',
                                height: 60,
                                width: 60),
                            applicationVersion: '1.0.0',
                            children: [
                              const Text(
                                  'This is an application which generates jokes randomly or in a given category. Also you can search queries in chucknorris.io.'),
                              const Center(
                                  child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(0, 20, 0, 10),
                                      child: Text("Author",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 22,
                                          )))),
                              const Text(
                                  "Kamila Khamidullina, Innopolis University bachelor student on software engeneering.")
                            ]);
                      },
                    )),
              ],
            ),
            body: RandomJokes(category: category, joke: "")));
  }
}

class RandomJokes extends StatefulWidget {
  String category;
  String joke;

  RandomJokes({required this.category, Key? key, required this.joke})
      : super(key: key);

  @override
  FirstJoke createState() => FirstJoke();
}

class FirstJoke extends State<RandomJokes> {
  @override
  Widget build(BuildContext context) {
    final _random = Random();
    var url = _baseUrl + widget.category.toString();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: FutureBuilder<Map<String, Object?>>(
                future: fetchJoke(url),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (data == null) {
                    return const CircularProgressIndicator();
                  }
                  widget.joke = data["value"].toString();
                  return SafeArea(
                      child: InkWell(
                          child: Center(
                              child: SingleChildScrollView(
                                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
                          child: Text(capitalize(widget.category),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 30,
                                color: Color.fromARGB(255, 69, 31, 112),
                              ))),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(40, 20, 40, 90),
                          child: Text(capitalize(widget.joke),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: Color.fromARGB(255, 49, 48, 48),
                              ))),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Container(
                              height: 40,
                              width: 110,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 69, 31, 112),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: InkWell(
                                      hoverColor:
                                          const Color.fromARGB(255, 32, 9, 58),
                                      highlightColor:
                                          const Color.fromARGB(255, 0, 0, 0),
                                      onTap: () {
                                        setState(() {
                                          widget.category = categories[_random
                                              .nextInt(categories.length)];
                                          url = _baseUrl +
                                              widget.category.toString();
                                          FutureBuilder<Map<String, Object?>>(
                                              future: fetchJoke(url),
                                              builder: (context, snapshot) {
                                                final data = snapshot.data;
                                                if (data == null) {
                                                  return const CircularProgressIndicator();
                                                }
                                                widget.joke =
                                                    data["value"].toString();
                                                return RandomJokes(
                                                    category: widget.category,
                                                    joke: widget.joke);
                                              });
                                        });
                                      },
                                      child: const Center(
                                        child: Text('Next',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 17,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                            )),
                                      )))))
                    ],
                  )))));
                })));
  }
}
