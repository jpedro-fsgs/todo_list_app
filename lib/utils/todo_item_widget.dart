import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hello_world/models/todo_item.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {super.key,
      required this.onChanged,
      required this.remove,
      required this.todoItem});

  final TodoItemClass todoItem;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? remove;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: todoItem.isDone ? Colors.pink.shade200 : Colors.pink.shade300,
          borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(
        top: 20,
        right: 20,
        left: 20,
        bottom: 0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Slidable(
          key: ValueKey(todoItem.id),
          endActionPane: ActionPane(
              motion: const StretchMotion(),
              extentRatio: 0.25,
              children: [
                SlidableAction(
                  onPressed: remove,
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    todoItem.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      decoration: todoItem.isDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: Colors.pink.shade700,
                      decorationThickness: 2,
                    ),
                  ),
                ),
                Checkbox(
                  value: todoItem.isDone,
                  onChanged: onChanged,
                  checkColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
