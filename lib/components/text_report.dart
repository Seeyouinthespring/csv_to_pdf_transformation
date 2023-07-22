import 'package:flutter/cupertino.dart';

import '../services/csv_parser.dart';

class TextReport extends StatelessWidget{

  final double avgSpeed5;
  final double avgSpeed10;

  const TextReport({super.key, required this.avgSpeed5, required this.avgSpeed10});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StyledText(text: 'Average speed for 5 minutes = $avgSpeed5'),
          StyledText(text: 'Average speed for 10 minutes = $avgSpeed10'),
          StyledText(text: 'Average speed for 5 minutes is ${CsVParser.roundDouble(avgSpeed5 * 100 / avgSpeed10, 2)} % of average speed for 10 minutes'),
          StyledText(text: 'Average speed for 10 minutes is ${CsVParser.roundDouble(avgSpeed10 * 100 / avgSpeed5, 2)} % of average speed for 5 minutes'),
        ],
      ),
    );
  }
}


class StyledText extends StatelessWidget{
  final String text;

  const StyledText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(text, style: const TextStyle(fontSize: 18),);
  }
}
