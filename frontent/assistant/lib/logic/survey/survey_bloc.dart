import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/logic/survey/survey_event.dart';
import 'package:assistant/logic/survey/survey_state.dart';
import 'package:assistant/model/survey/answer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SurveyBloc extends Bloc<SurveyEvent, SurveyState> {
  final HttpServiceRepository httpServiceRepo;
  final SharedPreferencesRepository sharedPreferencesRepo;

  SurveyBloc(
      {required this.httpServiceRepo, required this.sharedPreferencesRepo})
      : super(SurveyState()) {
    on<SurveyStarted>((event, emit) => emit(state.copyWith(
        surveyId: event.surveyId, numberOfQuestions: event.numberOfQuestions)));
    on<SurveyQuestionAnswered>((event, emit) {
      emit(
        state.copyWithAnswer(Answer(
          surveyId: state.surveyId,
          questionId: event.questionId,
          answerScore: event.answerValue,
        )),
      );
    });
    on<SurveySubmitted>((event, emit) async {
      print('Survey submitted');
      var accessToken = await sharedPreferencesRepo.getSavedAccessToken();
      await httpServiceRepo.sendSurvey(
          accessToken: accessToken, answers: state.answers);

      Get.back();
    });
  }
}
