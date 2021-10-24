
import 'package:bullseye/aboutpage.dart';
import 'package:flutter/material.dart';
import 'package:bullseye/textstyles.dart';
import 'package:bullseye/styledButton.dart';


class BottomState extends StatelessWidget {
  BottomState({Key? key, required this.score, required this.round, required this.onStartOver}) : super(key: key);

  final int score, round;
  final VoidCallback onStartOver;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StyledButton(
            onPressed: () {
              onStartOver();
            },
            icon: Icons.refresh
        ),
        Padding(
          padding: const EdgeInsets.only(right: 32.0, left: 32.0),
          child: Column(
            children: <Widget>[
              Text(
                "Score: ",
                style: LabelTextStyle.bodyText1(context),
              ),
              Text(
                "$score",
                style:ScoreNumberTextStyle.headline4(context),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 32.0, left: 32.0),
          child: Column(
            children: <Widget>[
              Text(
                "Round: ",
                style: LabelTextStyle.bodyText1(context),
              ),
              Text(
                "$round",
                style: ScoreNumberTextStyle.headline4(context),
              ),
            ],
          ),
        ),
        StyledButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => AboutPage())
              );
            },
            icon: Icons.info
        ),
      ],
    );
  }
}
