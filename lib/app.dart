import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:hw/category.dart';

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
      title: "ChukNorrisJokes",
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Jokes'),
          foregroundColor: Colors.white,
          backgroundColor: const Color.fromARGB(255, 69, 31, 112),
          shadowColor: const Color.fromARGB(255, 41, 1, 87),
        ),
        body: FutureBuilder<List>(
            future: fetchCategories(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                var categories = [];
                for (var i = 0; i < snapshot.data!.length; i++) {
                  categories.add(snapshot.data![i]);
                }
                return ListView.builder(
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
