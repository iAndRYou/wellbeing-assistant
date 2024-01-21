import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:assistant/common/info_icons.dart';
import 'package:assistant/common/snackbars.dart';
import 'package:assistant/logic/auth/auth_repo.dart';
import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/logic/user/user_bloc.dart';
import 'package:assistant/logic/user/user_event.dart';
import 'package:assistant/logic/user/user_state.dart';
import 'package:assistant/logic/user/user_status.dart';
import 'package:assistant/pages/home.dart';
import 'package:assistant/pages/loading.dart';
import 'package:assistant/pages/start.dart';
import 'package:assistant/utils/theme.dart' as theme;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FlutterError.onError = (details) => Snackbars.showMessageSnackbar(
        title: 'Error',
        message: details.exceptionAsString(),
        icon: const ErrorIcon(),
      );
  PlatformDispatcher.instance.onError = (error, stackTrace) {
    FlutterError.reportError(FlutterErrorDetails(exception: error));
    return true;
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => SharedPreferencesRepository()),
        RepositoryProvider(create: (context) => HttpServiceRepository()),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            preferencesRepository: context.read<SharedPreferencesRepository>(),
            httpServiceRepository: context.read<HttpServiceRepository>(),
          ),
        ),
      ],
      child: BlocProvider(
        create: (context) => UserBloc(
          authRepo: context.read<AuthRepository>(),
          httpRepo: context.read<HttpServiceRepository>(),
          preferencesRepo: context.read<SharedPreferencesRepository>(),
        )..add(UserAppStartup()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme.themeData,
            title: 'Thermo',
            home: state.status is UserLoadingLocallyStoredTokens
                ? const LoadingPage()
                : state.status is UserLocallyAuthorized
                    ? const HomePage()
                    : const StartPage(),
          ),
        ),
      ),
    );
  }
}
