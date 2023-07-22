import 'package:flutter/material.dart';

class DropdownSelector extends StatelessWidget{
  final int duration;
  final Function(int) onChanged;

  const DropdownSelector({super.key, required this.duration, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).highlightColor),
        color: Theme.of(context).cardColor,
      ),
      padding: const EdgeInsets.all(10),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: duration,
          icon: const Icon(Icons.keyboard_arrow_down),
          onChanged: (int? newValue){
            onChanged(newValue ?? 300);
          },
          items: const [
            DropdownMenuItem(value: 300, child: Text("5 min")),
            DropdownMenuItem(value: 600, child: Text("10 min")),
          ],
        ),
      ),
    );
  }
}
