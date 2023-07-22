import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget{
  final Function()? onPressed;
  final String title;

  const ActionButton({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
