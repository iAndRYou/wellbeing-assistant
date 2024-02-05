import 'dart:async';

import 'package:assistant/logic/home/home_event.dart';
import 'package:assistant/logic/home/home_state.dart';
import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/model/history_item.dart';
import 'package:assistant/pages/survey.dart';
import 'package:assistant/utils/styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HttpServiceRepository httpRepo;
  final SharedPreferencesRepository preferencesRepo;

  StreamSubscription? _surveySubscription;
  StreamSubscription? _updateSubscription;

  HomeBloc({required this.httpRepo, required this.preferencesRepo})
      : super(HomeState()) {
    on<HomeInit>((event, emit) async {
      var accessToken = await preferencesRepo.getSavedAccessToken();

      List<HistoryItem> historyItems =
          await httpRepo.getUserHistory(accessToken: accessToken);

      emit(state.copyWith(historyItems: historyItems));

      _surveySubscription ??=
          Stream.periodic(const Duration(seconds: 120)).listen((e) {
        add(HomeRequestSurvey());
      });

      _updateSubscription ??=
          Stream.periodic(const Duration(seconds: 30)).listen((e) {
        add(HomeUpdate());
      });
    });

    on<HomeUpdate>((event, emit) async {
      var accessToken = await preferencesRepo.getSavedAccessToken();

      List<HistoryItem> historyItems =
          await httpRepo.getUserHistory(accessToken: accessToken);

      emit(state.copyWith(historyItems: historyItems));
    });

    on<HomeRequestSurvey>((event, emit) async {
      var accessToken = await preferencesRepo.getSavedAccessToken();
      var survey = await httpRepo.getSurvey(accessToken: accessToken);

      if (survey != null) {
        Get.to(() => SurveyPage(survey: survey),
            transition: Styles.fadeTransition);
      }
    });

    on<HomeRequestSpecificSurvey>((event, emit) async {
      var accessToken = await preferencesRepo.getSavedAccessToken();
      var survey = await httpRepo.getSpecificSurvey(
          accessToken: accessToken, surveyType: event.surveyType);

      if (survey != null) {
        Get.to(() => SurveyPage(survey: survey),
            transition: Styles.fadeTransition);
      }
    });

    on<HomeGetMealProposition>((event, emit) async {
      var accessToken = await preferencesRepo.getSavedAccessToken();
      print('Getting meal proposition');
      // var meal = await httpRepo.getMealProposition(accessToken: accessToken);

      // if (meal != null) {
      //   SnackBar
      // }
    });

    on<HomeGetExerciseProposition>((event, emit) async {
      var accessToken = await preferencesRepo.getSavedAccessToken();
      print('Getting exercise proposition');
      // var exercise =
      //     await httpRepo.getExerciseProposition(accessToken: accessToken);

      // if (exercise != null) {
      //   Snackbar
      // }
    });
  }
}
