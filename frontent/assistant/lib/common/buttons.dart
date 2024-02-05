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

  static Widget roundedRectangleButtonWithText({
    required onPressed,
    required Color backgroundColor,
    Color iconColor = Colors.white,
    Color? textColor,
    required IconData icon,
    required Size size,
    required String text,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: iconColor,
              size: size.height - 40 > 20 ? size.height - 40 : 20),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
