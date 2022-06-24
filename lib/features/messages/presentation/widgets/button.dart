import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {required this.text,
      required this.doIt,
      required this.color,
      required this.icon,
      this.width,
      this.enabled = true,
      Key? key})
      : super(key: key);

  final String text;
  final VoidCallback doIt;
  final Color color;
  final IconData icon;
  final double? width;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(left: 10, right: 10),
      child: ElevatedButton.icon(
        icon: Icon(icon),
        style: ElevatedButton.styleFrom(primary: color),
        label: Text(text),
        onPressed: enabled ? doIt : null,
        onLongPress: enabled
            ? () {
                if (kDebugMode) {
                  print("Long press!");
                }
              }
            : null,
      ),
    );
  }
}
