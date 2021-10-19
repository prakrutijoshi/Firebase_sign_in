import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:signin_page/pages/authentication.dart';
import 'package:signin_page/pages/applicationstate.dart';
import 'package:signin_page/widgets/header.dart';
import 'package:signin_page/pages/entries.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:const Center(child: Text("Trainees Login")),
      ),

      body: ListView(
        children: [
          Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0), child: Header ("<-- RadixWeb Welcomes You -->")),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset("assets/welcome.png"),
              ),
            ],
          ),

          const SizedBox(height: 8),

          const Divider(
            thickness: 1,
            height: 8,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),

          Consumer<ApplicationState>(
              builder:(context,appState,_) => Authentication(
                  loginState: appState.loginState,
                  email: appState.email,
                  startLoginFlow: appState.startLoginFlow,
                  verifyEmail: appState.verifyEmail,
                  signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
                  cancelRegistration: appState.cancelRegistration,
                  registerAccount: appState.registerAccount,
                  signOut: appState.signOut,
              ),
          ),

          Consumer<ApplicationState>(
            builder: (context,appState,_) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(appState.loginState == ApplicationLoginState.loggedIn) ...[
                  Entries(
                      logEntry: (String entry, String time)
                        => appState.addToEntries(entry, time),
                    entries: appState.entryDatas,
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
