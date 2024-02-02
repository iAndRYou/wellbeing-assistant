import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assistant/pages/login.dart';
import 'package:assistant/pages/register.dart';
import 'package:assistant/utils/styles.dart';
import 'package:assistant/common/buttons.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 0, 15, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Your Own',
              style: Get.theme.textTheme.displaySmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            Text(
              'CLIMATE',
              style: Get.theme.textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                letterSpacing: 10,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.5),
            Buttons.startButton(
              label: 'Login',
              onPressed: () =>
                  Get.to(() => LoginPage(), transition: Styles.fadeTransition),
              style:
                  Styles.primaryButtonStyle(minimumSize: const Size(150, 50)),
            ),
            Buttons.startButton(
              label: 'Register',
              onPressed: () => Get.to(() => RegisterPage(),
                  transition: Styles.fadeTransition),
              style:
                  Styles.secondaryButtonStyle(minimumSize: const Size(150, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
