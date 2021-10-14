import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signin_page/pages/homepage.dart';
import 'package:signin_page/pages/applicationstate.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
        create: (context) => ApplicationState(),
        builder: (context,_) => const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:"Trainees Login",
      theme: ThemeData(
        buttonTheme:Theme.of(context).buttonTheme.copyWith(
          highlightColor:Colors.deepPurpleAccent,
        ),
        primarySwatch:Colors.deepPurple,
      ),
      home: const HomePage(),
    );
  }
}

