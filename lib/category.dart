import 'package:flutter/material.dart';
import 'joke.dart';

class Category extends StatelessWidget {
  final String name;

  const Category({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: 60,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          hoverColor: const Color.fromARGB(255, 219, 213, 245),
          highlightColor: const Color.fromARGB(255, 188, 174, 248),
          splashColor: const Color.fromARGB(255, 188, 174, 248),
          onTap: () {
            showBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Joke(category: name);
                });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(5.0, 2.0, 2.0, 2.0),
                  child: Icon(
                    Icons.arrow_right,
                    size: 30.0,
                  ),
                ),
                Center(
                  child: Text(name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color.fromARGB(255, 51, 50, 50))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
