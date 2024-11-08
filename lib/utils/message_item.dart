import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.pink.shade400,
                    fontSize: 18,
                  ),
                ));
  }
}