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

class Joke extends StatelessWidget {
  final String category;

  const Joke({
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    url = _baseUrl + category.toString();
    return SafeArea(
        child: Scaffold(
            body: FutureBuilder<Map<String, Object?>>(
                future: fetchJoke(),
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  if (data == null) {
                    return const CircularProgressIndicator();
                  }
                  var joke = data["value"].toString();
                  return ShowJoke(category: category, joke: joke);
                })));
  }
}

class ShowJoke extends StatelessWidget {
  final String joke;
  final String category;

  const ShowJoke({
    required this.category,
    required this.joke,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: InkWell(
            child: Center(
                child: Column(
      children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 20),
            child: Text(capitalize(category),
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Color.fromARGB(255, 69, 31, 112),
                ))),
        Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 90),
            child: Text(capitalize(joke),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Color.fromARGB(255, 49, 48, 48),
                ))),
        Container(
            height: 50,
            width: 110,
            color: const Color.fromARGB(255, 69, 31, 112),
            child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: InkWell(
                    hoverColor: const Color.fromARGB(255, 32, 9, 58),
                    highlightColor: const Color.fromARGB(255, 0, 0, 0),
                    onTap: () {
                      Navigator.pop(context);
                      showBottomSheet(
                          context: context,
                          builder: (BuildContext context) =>
                              Joke(category: category));
                    },
                    child: const Center(
                      child: Text('Next',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: Color.fromARGB(255, 255, 255, 255),
                          )),
                    ))))
      ],
    ))));
  }
}
