import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  const Question(this.question, {Key? key}) : super(key: key);

  final String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: Text(
        question,
        style: const TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
