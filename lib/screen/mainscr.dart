import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp/animation/route.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:todoapp/screen/addpage.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/widgets/add.dart';

import '../widgets/snack.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = true;
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TO-DO App"),
        centerTitle: true,
      ),
      body: Visibility(
        visible: isLoading,
        child: Center(child: CircularProgressIndicator()),
        replacement: RefreshIndicator(
          onRefresh: () => fetchTodo(),
          child: Visibility(
            visible: !items.isEmpty,
            replacement: const Center(
                child: Text(
              "No item in ToDO",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(201, 183, 186, 236),
                // fontFamily: GoogleFonts.aBeeZee().fontFamily,
              ),
            )),
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index] as Map;
                  final id = item["_id"] as String;
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: Color.fromARGB(255, 188, 205, 219))),
                      shadowColor: const Color.fromARGB(255, 157, 191, 219),
                      elevation: 1,
                      child: ListTile(
                        leading: CircleAvatar(child: Text("${index + 1}")),
                        title: Text(item["title"]),
                        subtitle: Text(item["description"]),
                        trailing: PopupMenuButton(onSelected: (value) {
                          if (value == "edit") {
                            navigateedit(item);
                          } else {
                            //delete and remove the item
                            DeleteById(id);
                          }
                        }, itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              child: Text('edit'),
                              value: 'edit',
                            ),
                            const PopupMenuItem(
                              child: Text("delete"),
                              value: "delete",
                            )
                          ];
                        }),
                      ),
                    ),
                  );
                }),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color.fromARGB(255, 11, 59, 99),
          onPressed: () => navigate(),
          label: Text(
            "Add TODO ",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 163, 161, 196)),
          )),
    );
  }

  Future<void> navigateedit(Map item) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddTodo(todo: item)));
    setState(() {
      isLoading = true;
      fetchTodo();
    });
  }

  Future<void> navigate() async {
    // await Navigator.of(context)
    //     .push(MaterialPageRoute(builder: (context) => AddTodo()));
    // setState(() {
    //   isLoading = true;
    //   fetchTodo();
    // });

    // await Navigator.of(context).push(ScaleAni(child: AddTodo()));
    // setState(() {
    //   isLoading = true;
    //   fetchTodo();
    // });

    //uper method for animation throught class

    //down method for variable

    await Navigator.of(context).push(ScaleAni(AddTodo()));
    // await Navigator.of(context).push(ScaleAni(NewAni1(AddTodo())));

    setState(() {
      isLoading = true;
      fetchTodo();
    });
  }

  // Future<void> fetchTodo() async {
  //   // setState(() {
  //   //   isLoading = true;
  //   // });
  //   final url = "https://api.nstack.in/v1/todos?page=1&limit=15";
  //   final uri = Uri.parse(url);

  //   final response = await http.get(uri);
  //   if (response.statusCode == 200) {
  //     final json = jsonDecode(response.body) as Map;
  //     final result = json['items'] as List;
  //     setState(() {
  //       items = result;
  //     });
  //   }

  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  Future<void> fetchTodo() async {
    final response = await TodoService.fetchTodo();
    if (response != null) {
      setState(() {
        items = response;
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  void DeleteById(String id) async {
    final url = "https://api.nstack.in/v1/todos/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    if (response.statusCode == 200) {
      final temp = items.where((element) => element['_id'] != id).toList();
      setState(() {
        // isLoading = true;
        final xyz = ShowMessage(message: "Item Deleted Succesfully");

        ScaffoldMessenger.of(context).showSnackBar(xyz);
        items = temp;
      });
    } else {
      final xyz = ShowMessage(
        message: "there is error in deleteing",
        isgoood: false,
      );

      ScaffoldMessenger.of(context).showSnackBar(xyz);
    }
  }
}
