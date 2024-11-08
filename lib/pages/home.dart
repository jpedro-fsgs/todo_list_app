
import 'package:flutter/material.dart';
import 'package:hello_world/models/todo_item.dart';
import 'package:hello_world/utils/floating_input.dart';
import 'package:hello_world/utils/message_item.dart';
import 'package:hello_world/utils/todo_item_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  SharedPreferences? _prefs;
  String? storedList;
  late List<TodoItemClass> toDoList;


  @override
  void initState(){
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    storedList = _prefs?.getString("todoList");
    toDoList = [];

  }


  final _controller = TextEditingController();


  void addToDo() {
    if (_controller.text.isEmpty) {
      return;
    }
    setState(() {
      toDoList.add(TodoItemClass(title: _controller.text));
    });
    _controller.clear();
  }

  void removeToDo(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  void checkBoxChanged(int index, bool? value) {
    setState(() {
      toDoList[index].isDone = value ?? true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink.shade100,
        appBar: AppBar(
          title: const Text("Todo List"),
          centerTitle: true,
          backgroundColor: Colors.pink.shade400,
          foregroundColor: Colors.white,
        ),
        body: Column(children: [
          Expanded(
            child: toDoList.isEmpty
                ? const MessageItem(text: "No Tasks added")
                : ListView.builder(
                    itemCount: toDoList.length,
                    itemBuilder: (BuildContext context, index) {
                      return TodoItem(
                          todoItem: toDoList[index],
                          onChanged: (value) => checkBoxChanged(index, value),
                          remove: (_) => removeToDo(index));
                    }),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FloatingInput(controller: _controller, onPressed: addToDo),
          )
        ]));
  }
}
