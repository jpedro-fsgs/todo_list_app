import 'package:flutter/material.dart';

class FloatingInput extends StatelessWidget {
  const FloatingInput(
      {super.key, required this.controller, required this.onPressed});

  final TextEditingController controller;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: "Add a Task",
                  filled: true,
                  fillColor: Colors.pink.shade50,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.pink),
                      borderRadius: BorderRadius.circular(16)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.pink),
                      borderRadius: BorderRadius.circular(16))),
            ),
          ),
          // SizedBox.square(dimension: 8,),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                minimumSize: const Size.square(56),
                shape: const CircleBorder(),
                backgroundColor: Colors.pink.shade300,
                foregroundColor: Colors.white),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
