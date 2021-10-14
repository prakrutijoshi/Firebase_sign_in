import 'package:flutter/material.dart';

class styledButton extends StatelessWidget {
  styledButton({required this.child, required this.onPressed});

  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) =>
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.deepPurpleAccent),
        ),
        onPressed: onPressed,
        child: child,
      );
}
