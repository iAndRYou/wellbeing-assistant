import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:assistant/common/info_icons.dart';
import 'package:assistant/common/snackbars.dart';
import 'package:assistant/logic/auth/form_submit_status.dart';
import 'package:assistant/logic/auth/login/login_bloc.dart';
import 'package:assistant/logic/auth/login/login_event.dart';
import 'package:assistant/logic/auth/login/login_state.dart';
import 'package:assistant/logic/user/user_bloc.dart';
import 'package:assistant/logic/user/user_event.dart';
import 'package:assistant/pages/home.dart';
import 'package:assistant/pages/register.dart';
import 'package:assistant/logic/auth/auth_repo.dart';
import 'package:assistant/utils/styles.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: BlocProvider(
          create: (context) => LoginBloc(
            authRepo: context.read<AuthRepository>(),
          ),
          child: BlocListener<LoginBloc, LoginState>(
            listenWhen: (previous, current) =>
                previous.formStatus != current.formStatus,
            listener: _handleSubmit,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Login',
                    style: Get.theme.textTheme.headlineSmall?.copyWith(
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  _emailField(),
                  _passwordField(),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _goToRegisterButton(),
                      _submitButton(),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit(BuildContext context, LoginState state) async {
    if (state.formStatus is FormSubmissionSuccess) {
      Snackbars.showMessageSnackbar(
          title: 'Success',
          message: 'Successfully logged in',
          icon: const SuccessIcon());

      UserBloc userBloc = context.read<UserBloc>()..add(UserUpdate());

      await Future.delayed(Snackbars.waitDuration);
      if (userBloc.state.user.isNotEmpty) {
        Get.offAll(() => const HomePage(), transition: Styles.fadeTransition);
      }
    } else if (state.formStatus is FormSubmissionTimeout) {
      Snackbars.showMessageSnackbar(
        title: 'Timeout',
        message:
            (state.formStatus as FormSubmissionTimeout).exception.toString(),
        icon: const TimeoutIcon(),
      );
    } else if (state.formStatus is FormSubmissionFailed) {
      Snackbars.showMessageSnackbar(
        title: 'Login failed',
        message:
            (state.formStatus as FormSubmissionFailed).exception.toString(),
        icon: const ErrorIcon(),
      );
    }
  }

  // Widgets
  Widget _emailField() => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              onChanged: (value) => context
                  .read<LoginBloc>()
                  .add(LoginUsernameChanged(email: value)),
              decoration: Styles.formInputDecoration(label: 'Email'),
            ),
          );
        },
      );

  Widget _passwordField() => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFormField(
              obscureText: true,
              onChanged: (value) => context
                  .read<LoginBloc>()
                  .add(LoginPasswordChanged(password: value)),
              decoration: Styles.formInputDecoration(label: 'Password'),
            ),
          );
        },
      );

  Widget _submitButton() => BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return state.formStatus is FormSubmitting
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: state.allFieldsFilled
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(LoginSubmitted());
                          }
                        }
                      : null,
                  style:
                      Styles.primaryButtonStyle(fixedSize: const Size(120, 40)),
                  child: Text(
                    'Login',
                    style: Get.theme.textTheme.labelMedium?.copyWith(
                      color: Get.theme.colorScheme.onPrimary,
                    ),
                  ),
                );
        },
      );

  Widget _goToRegisterButton() => TextButton(
        onPressed: () =>
            Get.off(() => RegisterPage(), transition: Styles.fadeTransition),
        child: Text(
          'Get started',
          style: TextStyle(
            color: Get.theme.colorScheme.secondary,
          ),
        ),
      );
}
