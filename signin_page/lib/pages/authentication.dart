import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signin_page/widgets/stylebutton.dart';
import 'package:signin_page/widgets/emailform.dart';
import 'package:signin_page/widgets/errordialog.dart';
import 'package:signin_page/widgets/passwordform.dart';
import 'package:signin_page/widgets/registerform.dart';

enum ApplicationLoginState{
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class Authentication extends StatelessWidget {
   const Authentication({
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
  });

  final ApplicationLoginState loginState;
  final String? email;

  final void Function() startLoginFlow;

  final void Function(
      String email,
      void Function(Exception e) error,
      ) verifyEmail;

  final void Function(
      String email,
      String password,
      void Function(Exception e) error,
      ) signInWithEmailAndPassword;

  final void Function() cancelRegistration;

  final void Function(
      String email,
      String displayName,
      String password,
      void Function(Exception e) error,
      ) registerAccount;

  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    switch (loginState) {
      case ApplicationLoginState.loggedOut:
        return Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 150, top: 8),
                  child: styledButton(
                    onPressed: () {
                      startLoginFlow();
                    },
                    child: const Center(
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
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
          ],
        );

      case ApplicationLoginState.emailAddress:
        return EmailForm(
          callback: (email) =>
              verifyEmail(
                email, (e) => showErrorDialog(context, 'Invalid Email', e),
              ),
        );

      case ApplicationLoginState.password:
        return PasswordForm(
            email: email!,
            login: (email, password) {
              signInWithEmailAndPassword(
                  email, password, (e) =>
                  showErrorDialog(context, "Login Failed", e)
              );
            }
        );

      case ApplicationLoginState.register:
        return RegisterForm(
          registerAccount: (email,
              displayName,
              password,) {
            registerAccount(
              email,
              displayName,
              password, (e) =>
                showErrorDialog(context, 'Account creation Failed', e),
            );
          },
          cancel: () {
            cancelRegistration();
          },
          email: email!,
        );

      case ApplicationLoginState.loggedIn:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 8),
              child: Row(
                children: [
                   Text("Hello ${FirebaseAuth.instance.currentUser!.displayName}",
                    style: const TextStyle(fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent),),
                  const SizedBox(width: 100),
                  styledButton(
                    onPressed: () {
                      signOut();
                    },
                    child: const Center(
                      child: Text(
                        "SIGN OUT",
                        style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                ],
              ),
            ),
            const SizedBox(height:8),
          ],
        );

      default:
        return Row(
          children: const [
            Text("This should not happen"),
          ],
        );
    }
  }
}
