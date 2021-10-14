import 'package:flutter/material.dart';
import 'package:signin_page/widgets/header.dart';
import 'package:signin_page/widgets/stylebutton.dart';

class EmailForm extends StatefulWidget {
  const EmailForm({required this.callback});
  final void Function(String email) callback;

  @override
  _EmailFormState createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _formkey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Header(
          "Sign In with Email",
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
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Enter your Email Address",
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return "Enter your Email to continue";
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 150,top: 8.0),
                          child: styledButton(
                            onPressed: () async {
                                if(_formkey.currentState!.validate()){
                                  widget.callback(_controller.text);
                                }
                              },
                              child: const Text("NEXT", style: TextStyle(fontSize: 15,fontStyle: FontStyle.italic, color: Colors.black),),
                          ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ),
      ],
    );
  }
}
