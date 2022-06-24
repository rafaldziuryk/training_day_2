import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/question.dart';

class OldPage extends StatefulWidget {
  const OldPage ({Key? key}) : super(key: key);

  @override
  State<OldPage > createState() => _OldPage();
}

class _OldPage extends State<OldPage > {
  var questions = [
    {
      "question": "Czy masz rozum i godność człowieka",
      "answers": ["Tak", "Nie", "Nie wiem"],
      "button_color": Colors.blue
    },
    {
      "question": "Jaki lubisz kolor",
      "answers": ["Niebieski", "Czerwony", "Czarny", "Nie wiem"],
      "button_color": Colors.red
    },
    {
      "question": "Kiedy była bitwa pod grunwaldem?",
      "answers": ["1410", "1721", "Nie wiem"],
      "button_color": Colors.blueGrey
    },
  ];
  bool _isTestCompleted = false;

  var _number = 0;
  var icons = [Icons.add, Icons.plus_one, Icons.delete];
  var answers = [
    ["Odpowiedź A", "Odpowiedź A1", "Odpowiedź A2"],
    ["Odpowiedź B", "Odpowiedź B1", "Odpowiedź B2"],
    ["Odpowiedź C", "Odpowiedź C1", "Odpowiedź C2"]
  ];
  var enabled = false;

  void _onClickButton() {
    setState(() {
      if (_number + 1 > 2) {
        enabled = true;
        _isTestCompleted = true;
        _number = 0;
      } else {
        _number++;
        _isTestCompleted = false;
        enabled = false;
      }
      if (kDebugMode) {
        print(_number);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
      ),
      body: Column(children: [
        Visibility(
          visible: !_isTestCompleted,
          child: Column(
            children: [
              Question(questions[_number]['question'] as String),
              ...(questions[_number]['answers'] as List<String>).map((answer) {
                return MyButton(
                  text: answer,
                  doIt: _onClickButton,
                  color: questions[_number]['button_color'] as Color,
                  icon: Icons.add,
                  width: double.infinity,
                );
              }).toList(),
            ],
          ),
        ),
        if (_isTestCompleted)
          const Text(
            "Hura, wypełniłeś test",
            style: TextStyle(
                fontSize: 28, color: Colors.red, fontWeight: FontWeight.bold),
          ),
        Row(
          children: [
            Expanded(
              child: MyButton(
                text: answers[0][_number],
                doIt: _onClickButton,
                color: Colors.blue,
                icon: Icons.add,
                width: null,
              ),
            ),
            Expanded(
              child: MyButton(
                text: answers[1][_number],
                doIt: _onClickButton,
                color: Colors.blue,
                icon: Icons.add,
                width: null,
              ),
            ),
            Expanded(
              child: MyButton(
                text: answers[2][_number],
                doIt: _onClickButton,
                color: Colors.blue,
                icon: Icons.add,
                width: null,
              ),
            ),
          ],
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onClickButton;
        },
      ),
    );
  }
}
