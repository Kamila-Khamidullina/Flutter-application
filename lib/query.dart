import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

const _baseUrl = 'https://api.chucknorris.io/jokes/search?query=';

Future<Map<String, Object?>> fetchJoke(url) async {
  final response = await get(Uri.parse(url));
  return jsonDecode(response.body) as Map<String, Object?>;
}

class QueryForm extends StatefulWidget {
  String responce;

  QueryForm({required this.responce, Key? key}) : super(key: key);

  @override
  QueryState createState() => QueryState();
}

class QueryState extends State<QueryForm> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
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
          body: Padding(
              padding: const EdgeInsets.fromLTRB(30, 15, 30, 10),
              child: SingleChildScrollView(
                child: Center(
                    child: Column(children: [
                  const Padding(
                      padding: EdgeInsets.fromLTRB(0, 25, 0, 20),
                      child: Text("Your query",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            color: Color.fromARGB(255, 69, 31, 112),
                          ))),
                  TextField(
                    controller: myController,
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 219, 213, 245),
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 177, 161, 248),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 70, 0, 10),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return FutureBuilder<Map<String, Object?>>(
                                    future: fetchJoke(_baseUrl +
                                        myController.text.toString()),
                                    builder: (context, snapshot) {
                                      final data = snapshot.data;
                                      if (data == null) {
                                        return const CircularProgressIndicator();
                                      }
                                      var joke = "";
                                      try {
                                        var result = data["result"] as List;
                                        var map = result[0] as Map;
                                        joke = map["value"].toString();
                                      } catch (e) {
                                        joke =
                                            "Oooops, Chuck Norris can't answer :(";
                                      }
                                      return AlertDialog(content: Text(joke));
                                    });
                              });
                        },
                        icon: const Icon(Icons.search, size: 17),
                        label: const Text("Search"),
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 69, 31, 112),
                            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            textStyle: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w500)),
                      )),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
                      child: Image.asset('assets\\images\\logo.png')),
                ])),
              )),
        ));
  }
}
