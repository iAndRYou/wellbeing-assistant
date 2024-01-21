import 'package:flutter/material.dart';

class Buttons {
  static Widget startButton(
      {required String label, required onPressed, required ButtonStyle style}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: Text(label),
      ),
    );
  }

  static Widget roundedRectangleButton({
    required onPressed,
    required Color backgroundColor,
    Color iconColor = Colors.white,
    required IconData icon,
    required Size size,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        minimumSize: size,
        maximumSize: size,
        padding: const EdgeInsets.all(0),
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
      child: Icon(icon,
          color: iconColor,
          size: size.height - 20 > 20 ? size.height - 20 : 20),
    );
  }
}
