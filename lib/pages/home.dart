import 'dart:convert';

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
  List<String>? storedList;
  List<TodoItemClass> toDoList = [];

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    storedList = _prefs?.getStringList("toDoList");

    if (storedList != null) {
      setState(() {
        toDoList = storedList!
            .map((todo) => TodoItemClass.fromJson(jsonDecode(todo)))
            .toList();
      });
    }
  }

  final _controller = TextEditingController();

  void saveToDoList() {
    List<String> storeList =
        toDoList.map((todo) => jsonEncode(todo.toJson())).toList();
    _prefs?.setStringList("toDoList", storeList);
  }

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
    saveToDoList();
  }

  void checkBoxChanged(int index, bool? value) {
    setState(() {
      toDoList[index].isDone = value ?? true;
    });
    saveToDoList();
  }

  void reorderList(oldIndex, newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex--;
      final todo = toDoList.removeAt(oldIndex);
      toDoList.insert(newIndex, todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pink.shade100,
        appBar: AppBar(
          title: const Text("ToDo List"),
          centerTitle: true,
          backgroundColor: Colors.pink.shade400,
          foregroundColor: Colors.white,
        ),
        body: Column(children: [
          Expanded(
              child: toDoList.isEmpty
                  ? const MessageItem(text: "No Tasks added")
                  : ReorderableListView.builder(
                      scrollController: _scrollController,
                      onReorder: reorderList,
                      itemCount: toDoList.length,
                      itemBuilder: (BuildContext context, index) {
                        return TodoItem(
                            key: ValueKey(toDoList[index].id),
                            todoItem: toDoList[index],
                            onChanged: (value) => checkBoxChanged(index, value),
                            remove: (_) => removeToDo(index));
                      },
                      proxyDecorator: (Widget child, int index,
                          Animation<double> animation) {
                        return Material(
                          color: Colors.transparent,
                          child: Transform.scale(
                            scale: 1.05,
                            child: child,
                          ),
                        );
                      },
                    )),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: FloatingInput(controller: _controller, onPressed: addToDo),
          )
        ]));
  }
}
