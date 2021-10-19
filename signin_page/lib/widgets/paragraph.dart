import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, this.colour);
  final String content;
  final MaterialColor colour;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(2.0),
    child: Text(
      content,
      style: TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.italic,
          color: colour,
      ),
    ),
  );
}