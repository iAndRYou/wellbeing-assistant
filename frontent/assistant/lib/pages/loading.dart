import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.primary,
      body: Center(
        child: CircularProgressIndicator(
          color: Get.theme.colorScheme.onPrimary,
        ),
      ),
    );
  }
}
