import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:assistant/common/info_icons.dart';
import 'package:assistant/common/snackbars.dart';
import 'package:assistant/logic/auth/form_submit_status.dart';
import 'package:assistant/logic/auth/register/register_bloc.dart';
import 'package:assistant/logic/auth/register/register_event.dart';
import 'package:assistant/logic/auth/register/register_state.dart';
import 'package:assistant/logic/user/user_bloc.dart';
import 'package:assistant/logic/user/user_event.dart';
import 'package:assistant/pages/home.dart';
import 'package:assistant/pages/login.dart';
import 'package:assistant/logic/auth/auth_repo.dart';
import 'package:assistant/utils/styles.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Styles.defaultPadding,
        child: BlocProvider(
          create: (context) => RegisterBloc(
            authRepo: context.read<AuthRepository>(),
          ),
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: _handleSubmit,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Get started',
                    style: Get.theme.textTheme.headlineSmall?.copyWith(
                      color: Get.theme.colorScheme.primary,
                    ),
                  ),
                  _usernameField(),
                  _emailField(),
                  _passwordField(),
                  _confirmPasswordField(),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _goToLoginButton(),
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

  void _handleSubmit(BuildContext context, RegisterState state) async {
    if (state.formStatus is FormSubmissionSuccess) {
      Snackbars.showMessageSnackbar(
          title: 'Success',
          message: 'Successfully registered',
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
  Widget _usernameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            onChanged: (value) => context
                .read<RegisterBloc>()
                .add(RegisterUsernameChanged(username: value)),
            decoration: Styles.formInputDecoration(label: 'Username'),
          ),
        );
      },
    );
  }

  Widget _emailField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            onChanged: (value) => context
                .read<RegisterBloc>()
                .add(RegisterEmailChanged(email: value)),
            validator: (value) => state.isValidEmail ? null : 'Invalid email',
            decoration: Styles.formInputDecoration(label: 'Email'),
          ),
        );
      },
    );
  }

  Widget _passwordField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            obscureText: true,
            onChanged: (value) => context
                .read<RegisterBloc>()
                .add(RegisterPasswordChanged(password: value)),
            validator: (value) => state.isValidPassword
                ? null
                : 'Password must be at least 6 characters',
            decoration: Styles.formInputDecoration(label: 'Password'),
          ),
        );
      },
    );
  }

  Widget _confirmPasswordField() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            obscureText: true,
            onChanged: (value) => context
                .read<RegisterBloc>()
                .add(RegisterConfirmPasswordChanged(confirmPassword: value)),
            validator: (value) =>
                state.isValidConfirmPassword ? null : 'Passwords do not match',
            decoration: Styles.formInputDecoration(label: 'Confirm Password'),
          ),
        );
      },
    );
  }

  Widget _submitButton() {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: state.allFieldsFilled
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          context.read<RegisterBloc>().add(RegisterSubmitted());
                        }
                      }
                    : null,
                style:
                    Styles.primaryButtonStyle(fixedSize: const Size(120, 40)),
                child: Text(
                  'Register',
                  style: Get.theme.textTheme.labelMedium?.copyWith(
                    color: Get.theme.colorScheme.onPrimary,
                  ),
                ),
              );
      },
    );
  }

  Widget _goToLoginButton() {
    return TextButton(
      onPressed: () =>
          Get.off(() => LoginPage(), transition: Styles.fadeTransition),
      child: Text(
        'Already signed up?',
        style: Get.theme.textTheme.labelLarge?.copyWith(
          color: Get.theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
