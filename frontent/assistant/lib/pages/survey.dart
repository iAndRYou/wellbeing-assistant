import 'package:assistant/common/buttons.dart';
import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/logic/survey/survey_bloc.dart';
import 'package:assistant/logic/survey/survey_event.dart';
import 'package:assistant/logic/survey/survey_state.dart';
import 'package:assistant/model/survey/question.dart';
import 'package:assistant/model/survey/survey.dart';
import 'package:assistant/pages/home.dart';
import 'package:assistant/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class SurveyPage extends StatelessWidget {
  const SurveyPage({super.key, required this.survey});

  final Survey survey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SurveyBloc(
        httpServiceRepo: context.read<HttpServiceRepository>(),
        sharedPreferencesRepo: context.read<SharedPreferencesRepository>(),
      )..add(SurveyStarted(
          surveyId: survey.id, numberOfQuestions: survey.questions.length)),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          minimum: Styles.contentMarginTop,
          child: Padding(
            padding: Styles.homePagePadding,
            child: SingleChildScrollView(
              child: BlocBuilder<SurveyBloc, SurveyState>(
                  builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(survey.name.toUpperCase(),
                        style: Get.textTheme.headlineSmall),
                    Text('Please answer few short questions:',
                        style: Get.textTheme.titleLarge),
                    Styles.defaultVerticalSpace,
                    _surveyQuestions(),
                    Styles.defaultVerticalSpace,
                    Buttons.roundedRectangleButton(
                      onPressed: state.isSurveyFilled
                          ? () {
                              context.read<SurveyBloc>().add(SurveySubmitted());
                              Get.off(() => const HomePage(),
                                  transition: Styles.fadeTransition);
                            }
                          : null,
                      backgroundColor: Get.theme.colorScheme.secondary,
                      size: const Size(double.infinity, 50),
                      icon: Icons.send,
                    ),
                    Styles.defaultVerticalSpace,
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _surveyQuestions() => Column(
        children: survey.questions
            .map((question) => _questionCard(question))
            .toList(),
      );

  Widget _questionCard(Question question) {
    return BlocBuilder<SurveyBloc, SurveyState>(builder: (context, state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${question.questionContent}:",
              style: Get.textTheme.titleMedium),
          Styles.defaultVerticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RatingBar.builder(
                glow: false,
                itemSize: 50,
                initialRating: 0,
                itemCount: 5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return const Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                      );
                    case 1:
                      return const Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                      );
                    case 2:
                      return const Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                      );
                    case 3:
                      return const Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.lightGreen,
                      );
                    case 4:
                      return const Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                      );
                    default:
                      return Container();
                  }
                },
                onRatingUpdate: (rating) {
                  context.read<SurveyBloc>().add(SurveyQuestionAnswered(
                        questionId: question.id,
                        answerValue: rating.toInt() > 0 ? rating.toInt() : 1,
                      ));
                },
              ),
            ],
          ),
          Styles.largeVerticalSpace,
        ],
      );
    });
  }
}
