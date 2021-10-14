import 'package:flutter/material.dart';
import 'package:signin_page/widgets/header.dart';
import 'package:signin_page/widgets/stylebutton.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    required this.registerAccount,
    required this.cancel,
    required this.email,
  });

  final void Function(String email, String displayName, String password) registerAccount;
  final void Function() cancel;
  final String email;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final _formkey = GlobalKey<FormState>(debugLabel: '_RegisterFormState');
  final _emailcontroller = TextEditingController();
  final _displayNamecontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  @override
  void initState(){
    super.initState();
    _emailcontroller.text=widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header("Create Account"),
        const Divider(
          thickness: 1,
          height: 8,
          indent: 8,
          endIndent: 8,
          color: Colors.grey,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _emailcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Email Address',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter Email to continue';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _displayNamecontroller,
                    decoration: const InputDecoration(
                      hintText: 'Enter your Full Name',
                    ),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter Name to continue';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordcontroller,
                    decoration: const InputDecoration(
                      hintText: 'Enter Password',
                    ),
                    obscureText: true,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter Password to continue';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 20),
                      styledButton(
                          onPressed: widget.cancel,
                          child: const Text("CANCEL"),
                      ),
                      const SizedBox(width: 150),
                      styledButton(
                        child: const Text("SAVE"),
                        onPressed: () async {
                          if(_formkey.currentState!.validate()){
                            widget.registerAccount(
                              _emailcontroller.text,
                              _displayNamecontroller.text,
                              _passwordcontroller.text,
                            );
                          }
                        },
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
