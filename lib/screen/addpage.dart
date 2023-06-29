import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/widgets/snack.dart';

class AddTodo extends StatefulWidget {
  final Map? todo;

  const AddTodo({super.key, this.todo});
  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titlecntr = TextEditingController();

  TextEditingController descntrl = TextEditingController();
  bool isEdit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final title = todo["title"];
      final desc = todo["description"];
      titlecntr.text = title;
      descntrl.text = desc;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Todo" : "Add Todo"),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          TextField(
            decoration: const InputDecoration(
              hintText: 'Eneter Title',
              label: Text('Todo Title'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 5, 19, 59),
                  width: 5,
                ),
              ),
            ),
            controller: titlecntr,
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descntrl,
            decoration: const InputDecoration(
              hintText: "Enter Discription for upper title",
              labelText: "Discription",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 5, 19, 59),
                  width: 5,
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            maxLines: 8,
            minLines: 5,
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
                onPressed: () {
                  isEdit ? updatedata() : submitdata();
                },
                style: const ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        side: BorderSide(
                            color: Color.fromARGB(255, 153, 176, 196),
                            width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
                    padding: MaterialStatePropertyAll(EdgeInsets.all(20)),
                    backgroundColor: MaterialStatePropertyAll(
                        Color.fromARGB(255, 15, 9, 53))),
                child: Text(
                  isEdit ? "Edit" : "submit",
                  style: TextStyle(
                      color: Color.fromARGB(255, 129, 157, 180), fontSize: 20),
                )),
          ),
        ],
      ),
    );
  }

  void submitdata() async {
//get data
    final title = titlecntr.text;
    final desc = descntrl.text;
    final body = {"title": title, "description": desc, "is_completed": false};
//send data
    final utl = "https://api.nstack.in/v1/todos";
    final uri = Uri.parse(utl);
    final response = await http.post(uri,
        body: jsonEncode(body), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      showsuccess();
      Navigator.of(context).pop();
    } else
      notshow();
//visual
  }

  void showsuccess() {
    final sncak = ShowMessage(message: "Todo set Successfully");
    ScaffoldMessenger.of(context).showSnackBar(sncak);
  }

  void notshow() {
    final snack = ShowMessage(
      message: "There is Error!!!",
      isgoood: false,
    );
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  void updatedata() async {
    final todo = widget.todo;
    if (todo != null) {
      final id = todo["_id"];
      final title = titlecntr.text;
      final desc = descntrl.text;
      final body = {
        "title": title,
        "description": desc,
        "is_completed": false,
      };
      final url = "https://api.nstack.in/v1/todos/$id";
      final uri = Uri.parse(url);
      final response = await http.put(uri,
          body: jsonEncode(body),
          headers: {"Content-Type": "application/json"});

      if (response.statusCode == 200) {
        showsuccess();
      } else {
        notshow();
      }
    }
  }
}
