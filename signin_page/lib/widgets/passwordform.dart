import 'package:flutter/material.dart';
import 'package:signin_page/widgets/header.dart';
import 'package:signin_page/widgets/stylebutton.dart';

class PasswordForm extends StatefulWidget {
  const PasswordForm({
    required this.login,
    required this.email
  });

  final void Function(String email, String password) login;
  final String email;

  @override
  _PasswordFormState createState() => _PasswordFormState();
}

class _PasswordFormState extends State<PasswordForm> {
  final _formkey = GlobalKey<FormState>(debugLabel: '_PasswordFormState');
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  @override
  void initState(){
    super.initState();
    _emailcontroller.text = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(
          "Sign In"
        ),
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
                        hintText: "Enter Your Email Address",
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                            return "Enter your Email to continue";
                        }
                        return null;
                      },
                    ) ,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _passwordcontroller,
                    decoration: const InputDecoration(
                      hintText: "Enter Password",
                    ),
                    obscureText: true,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Enter Password to continue";
                      }
                      return null;
                    },
                  ) ,
                ),
              ],
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 150),
                styledButton(
                    child: const Text("SIGN IN", style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic, color: Colors.black),),
                    onPressed: () async {
                      if(_formkey.currentState!.validate()){
                        widget.login(
                          _emailcontroller.text,
                          _passwordcontroller.text,
                        );
                      }
                    },
                ),
              ],
            ),
        ),
      ],
    );
  }
}
