import 'dart:async';
import 'package:signin_page/widgets/header.dart';
import 'package:signin_page/widgets/paragraph.dart';
import 'package:signin_page/widgets/stylebutton.dart';
import 'package:flutter/material.dart';

class EntryData {
  EntryData({ required this. dataname, required this.dataentry, required this.datatime});

  final String dataname;
  final String dataentry;
  final String datatime;
}

class Entries extends StatefulWidget {
  const Entries({required this.logEntry, required this.entries});

  final Future<void> Function(String entry, String time) logEntry;
  final List<EntryData> entries;

  @override
  _EntriesState createState() => _EntriesState();
}

class _EntriesState extends State<Entries> {

  final _formkey = GlobalKey<FormState>(debugLabel: '_entryState');
  final _entrycontroller = TextEditingController();
  final _timecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Header('Daily Log'),
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
                    controller: _timecontroller,
                    decoration: const InputDecoration(
                        hintText: 'Time Log'
                    ),
                    validator: (value) {
                      if(value == null || value.isEmpty) {
                        return 'Add time log to continue';
                      }
                      return null;
                    },
                  ),
                ),

                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _entrycontroller,
                      decoration: const InputDecoration(
                        hintText: "Work Log"
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty){
                          return 'Add an Entry to continue';
                        }
                        return null;
                      },
                    ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const SizedBox(width: 140),
                      styledButton(
                          child:  Row(
                            children: const [
                              Icon(Icons.send, color: Colors.deepPurpleAccent),
                              SizedBox(width: 5),
                              Text("SEND", style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),),
                            ],
                          ),
                          onPressed: () async {
                            if(_formkey.currentState!.validate()) {
                               widget.logEntry(
                                  _entrycontroller.text,
                                  _timecontroller.text,
                              );
                               _entrycontroller.clear();
                               _timecontroller.clear();
                            }
                          }
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height:8),
          for (var dataentry in widget.entries)
            Row(
              children: [
                Paragraph( "${dataentry.dataname} : " , Colors.deepPurple),
                Paragraph(" ${dataentry.dataentry} for ${dataentry.datatime}", Colors.grey)
              ],
            ),
        const SizedBox(height: 8),
      ],
    );
  }
}
