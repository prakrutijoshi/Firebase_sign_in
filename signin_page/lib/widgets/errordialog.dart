import 'package:flutter/material.dart';
import 'package:signin_page/widgets/stylebutton.dart';

void showErrorDialog(BuildContext context, String title, Exception e) {
  showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          actions: [
            styledButton(
                child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.deepPurpleAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
  );
}