import 'package:flutter/material.dart';
import 'package:flutter_animated_icons/icons8.dart';
import 'package:lottie/lottie.dart';

abstract class InfoIcon extends StatefulWidget {
  final String iconData;
  const InfoIcon({super.key, required this.iconData});

  @override
  State<InfoIcon> createState() => _InfoIconState();
}

class _InfoIconState extends State<InfoIcon> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward(from: 0.5);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.iconData,
      controller: controller,
      height: 50,
    );
  }
}

class ErrorIcon extends InfoIcon {
  const ErrorIcon({super.key, super.iconData = Icons8.cross});
}

class SuccessIcon extends InfoIcon {
  const SuccessIcon({super.key, super.iconData = Icons8.checkmark_ok});
}

class TimeoutIcon extends InfoIcon {
  const TimeoutIcon({super.key, super.iconData = Icons8.time});
}
