import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:hw/category.dart';

var categories = [];
const _baseUrl = 'https://api.chucknorris.io/jokes/categories';

Future<List> fetchCategories() async {
  final response = await get(Uri.parse(_baseUrl));
  return jsonDecode(response.body);
}

class JsonWidget extends StatelessWidget {
  const JsonWidget({Key? key}) : super(key: key);

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
                        applicationIcon: Image.asset('assets\\images\\logo.png',
                            height: 60, width: 60),
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
        body: FutureBuilder<List>(
            future: fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                for (var i = 0; i < snapshot.data!.length; i++) {
                  categories.add(snapshot.data![i]);
                }
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    primary: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Category(name: categories[index]);
                    });
              }
            }),
      ),
    );
  }
}
