import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

const _baseUrl = 'https://api.chucknorris.io/jokes/random?category=';
var url = '';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

Future<Map<String, Object?>> fetchJoke() async {
  final response = await get(Uri.parse(url));
  return jsonDecode(response.body) as Map<String, Object?>;
}

class Jokes extends StatefulWidget {
  final String category;
  String joke;

  Jokes({required this.category, Key? key, required this.joke})
      : super(key: key);

  @override
  FirstJoke createState() => FirstJoke();
}

class FirstJoke extends State<Jokes> {
  @override
  Widget build(BuildContext context) {
    url = _baseUrl + widget.category.toString();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: FutureBuilder<Map<String, Object?>>(
                future: fetchJoke(),
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
                                          FutureBuilder<Map<String, Object?>>(
                                              future: fetchJoke(),
                                              builder: (context, snapshot) {
                                                final data = snapshot.data;
                                                if (data == null) {
                                                  return const CircularProgressIndicator();
                                                }
                                                widget.joke =
                                                    data["value"].toString();
                                                return Jokes(
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
