import 'dart:math';

import 'package:bullseye/bottomstate.dart';
import 'package:bullseye/control.dart';
import 'package:bullseye/gamemodel.dart';
import 'package:bullseye/hitmebutton.dart';
import 'package:bullseye/prompt.dart';
import 'package:bullseye/styledButton.dart';
import 'package:bullseye/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(BullsEyeApp());

class BullsEyeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      title: 'BullsEye',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GamePage(title: 'BullsEye'),
    );
  }
}

class GamePage extends StatefulWidget {
  GamePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _alertIsVisible = false;
  late GameModel _model;

  @override
  void initState() {
    print("init state");
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 48.0, bottom: 32.0),
                child: Prompt(targetValue: _model.target),
              ),
              Control(
                model: _model,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: HitmeButton(
                    text: "HIT ME !",
                    onPressed: () {
                      _showAlert(context);
                      this._alertIsVisible = true;
                      print("Button Pressed");
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: BottomState(
                  score: _model.totalScore,
                  round: _model.round,
                  onStartOver: _startNewGame,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _sliderValue() => _model.current;

  num _pointsForCurrentRound() {
    var maximumScore = 100;
    var diff = _amountOff();
    var bonus = 0;
    if (diff == 0) {
      bonus = 100;
    } else if (diff == 1) {
      bonus = 50;
    }
    return maximumScore - diff + bonus;
  }

  int _newTargetValue() => Random().nextInt(100) + 1;

  void _startNewGame() {
    setState(() {
      _model.round = GameModel.ROUND_START;
      _model.totalScore = GameModel.SCORE_START;
      _model.current = GameModel.SLIDER_START;
      _model.target = _newTargetValue();
    });
  }

  void _showAlert(BuildContext context) {
    Widget okButton = StyledButton(
      icon: Icons.close,
      onPressed: () {
        Navigator.of(context).pop();
        this._alertIsVisible = false;
        setState(() {
          _model.totalScore += _pointsForCurrentRound().toInt();
          _model.target = _newTargetValue();
          _model.round++;
        });
      },
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              _alertTitle(),
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "THE SLIDER'S VALUE IS",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${_sliderValue()}",
                  style: TargetTextStyle.bodyText1(context),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "\n You scored ${_pointsForCurrentRound()} points this round",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: <Widget>[okButton],
            elevation: 5,
          );
        });
  }

  int bonusPoints() {
    int points = _pointsForCurrentRound().toInt();
    if (points == 100) {
      points += 100;
    } else if (points == 99) {
      points += 50;
    }
    return points;
  }

  int _amountOff() => (_model.target - _sliderValue()).abs();

  String _alertTitle() {
    var diff = _amountOff();
    String title;
    if (diff == 0) {
      title = "Perfect!";
    } else if (diff < 5) {
      title = "You almost had it";
    } else if (diff <= 10) {
      title = "Not Bad";
    } else {
      title = "Are you even trying";
    }

    return title;
  }
}
