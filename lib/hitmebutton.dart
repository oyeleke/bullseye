import 'package:flutter/material.dart';

class HitmeButton extends StatelessWidget {
  HitmeButton({required this.text, required this.onPressed});

  final String text;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.red[700],
      splashColor: Colors.redAccent,
      child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            text,
            maxLines: 1,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0),
          )),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: Colors.white)),
    );
  }
}
