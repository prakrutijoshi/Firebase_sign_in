import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.title);
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(12.0),
    child: Center(
      child: Text(
        title,
        style: const TextStyle(fontSize: 24, fontStyle: FontStyle.italic, color: Colors.deepPurpleAccent),
      ),
    ),
  );
}
