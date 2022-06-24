import 'package:flutter/material.dart';

class MyFloatingButton extends StatelessWidget {
  const MyFloatingButton({required this.image, required this.doIt, Key? key})
      : super(key: key);

  final IconData image;
  final VoidCallback doIt;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: FractionalOffset.bottomRight,
      margin: const EdgeInsets.only(right: 20, bottom: 20),
      // transform: Matrix4.rotationZ(0.1),
      child: FloatingActionButton(
        onPressed: doIt,
        child: Icon(image),
      ),
    );
  }
}
