import 'package:flutter/material.dart';
import 'package:bullseye/textstyles.dart';

class Prompt extends StatelessWidget {
  Prompt({required this.targetValue});
  final int targetValue;

  @override
  Widget build(BuildContext context) {
    print("$targetValue");
    return Column(
      children: <Widget>[
        Text("PUT THE BULLSEYE AS CLOSE AS YOU CAN TO", style: LabelTextStyle.bodyText1(context),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("$targetValue", style: TargetTextStyle.bodyText1(context)),
        )
      ],
    );
  }

}