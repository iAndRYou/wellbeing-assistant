import 'package:assistant/common/buttons.dart';
import 'package:assistant/logic/exercise/exercise_bloc.dart';
import 'package:assistant/logic/exercise/exercise_event.dart';
import 'package:assistant/logic/exercise/exercise_state.dart';
import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/logic/user/user_bloc.dart';
import 'package:assistant/logic/user/user_event.dart';
import 'package:assistant/model/exercise.dart';
import 'package:assistant/pages/home.dart';
import 'package:assistant/utils/styles.dart';
import 'package:assistant/utils/enums.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wheel_picker/wheel_picker.dart';

class LogExcercisePage extends StatelessWidget {
  const LogExcercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ExerciseBloc(
        httpServiceRepo: context.read<HttpServiceRepository>(),
        sharedPreferencesRepo: context.read<SharedPreferencesRepository>(),
      )..add(ExerciseInit()),
      child:
          BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            minimum: Styles.contentMarginTop,
            child: Padding(
              padding: Styles.homePagePadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Choose your exercise', style: Get.textTheme.titleLarge),
                  _selectExercise(),
                  Styles.defaultVerticalSpace,
                  _currentExercise(),
                  Buttons.roundedRectangleButton(
                    onPressed: state.hasCurrentExerciseFilled
                        ? () {
                            context.read<ExerciseBloc>().add(ExerciseSubmit());
                            context.read<UserBloc>().add(UserRequestSurvey());
                            Get.off(() => const HomePage(),
                                transition: Styles.fadeTransition);
                          }
                        : null,
                    backgroundColor: Get.theme.colorScheme.secondary,
                    size: const Size(double.infinity, 50),
                    icon: Icons.add,
                  ),
                  Styles.defaultVerticalSpace,
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _selectExercise() {
    return BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
      return DropdownSearch<Exercise>(
        items: state.exercises,
        itemAsString: (exercise) => 'Select an exercise',
        onChanged: (exercise) {
          context.read<ExerciseBloc>().add(ExerciseSelected(exercise!));
        },
        filterFn: (item, filter) =>
            item.name.toLowerCase().contains(filter.toLowerCase()),
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchDelay: const Duration(milliseconds: 100),
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.name),
            leading: Icon(
              item.categoryIcon,
              color: Get.theme.colorScheme.primary,
            ),
            trailing: const Icon(Icons.add),
          ),
          scrollbarProps: const ScrollbarProps(
            thickness: 5,
            mainAxisMargin: 5,
            radius: Styles.defaultRadius,
          ),
          menuProps: const MenuProps(
            elevation: 5,
            borderRadius: Styles.defaultBorderRadius,
          ),
          searchFieldProps: TextFieldProps(
            decoration: Styles.searchInputDecoration(
              label: 'Search',
              labelColor: Get.theme.colorScheme.secondary,
              fillColor: Get.theme.colorScheme.secondary.withOpacity(0.1),
            ),
          ),
        ),
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              label:
                  Text('Select an exercise', style: Get.textTheme.titleSmall),
              border: InputBorder.none),
        ),
      );
    });
  }

  Widget _currentExercise() => Expanded(
        child: Center(
          child: BlocBuilder<ExerciseBloc, ExerciseState>(
            builder: (context, state) => state.currentExercise != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.currentExercise!.name,
                                style:
                                    Get.theme.textTheme.headlineSmall?.copyWith(
                                  color: Get.theme.colorScheme.primary,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  color: Get.theme.colorScheme.secondary,
                                  borderRadius: Styles.defaultBorderRadius,
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      state.currentExercise!.categoryIcon,
                                      color: Get.theme.colorScheme.onSecondary,
                                    ),
                                    Styles.smallHorizontalSpace,
                                    Text(
                                      state.currentExercise!.category,
                                      style: Get.theme.textTheme.titleLarge
                                          ?.copyWith(
                                        color:
                                            Get.theme.colorScheme.onSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            state.currentExercise!.exerciseType.name,
                            style: Get.theme.textTheme.titleLarge?.copyWith(
                              color: Get.theme.colorScheme.onBackground,
                            ),
                          ),
                        ],
                      ),
                      Styles.defaultVerticalSpace,
                      state.currentExercise!.exerciseType ==
                              ExerciseType.repetitions
                          ? _repetitionsSelector()
                          : _timeSelector(),
                    ],
                  )
                : Text('No exercise selected', style: Get.textTheme.titleSmall),
          ),
        ),
      );

  Widget _repetitionsSelector() {
    return BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'How many times did you repeat this exercise?',
            style: Get.textTheme.titleSmall,
          ),
          WheelPicker(
            itemCount: 101,
            looping: false,
            style: const WheelPickerStyle(
              size: 100,
              itemExtent: 30,
              surroundingOpacity: 0.7,
              magnification: 1.5,
              diameterRatio: 1.5,
            ),
            selectedIndexColor: Get.theme.colorScheme.secondary,
            builder: (context, index) {
              return Text('$index', style: Get.textTheme.titleMedium);
            },
            onIndexChanged: (index) {
              context.read<ExerciseBloc>()
                ..add(ExerciseSelectedRepetitionsChanged(index))
                ..add(ExerciseSelectedTimeChanged(0));
            },
          ),
        ],
      );
    });
  }

  Widget _timeSelector() {
    return BlocBuilder<ExerciseBloc, ExerciseState>(builder: (context, state) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'How long were you exercising?',
            style: Get.textTheme.titleSmall,
          ),
          WheelPicker(
            initialIndex: state.selectedExercise?.time != null
                ? state.selectedExercise!.time ~/ 5
                : 0,
            itemCount: 61,
            looping: false,
            style: const WheelPickerStyle(
              size: 100,
              itemExtent: 30,
              surroundingOpacity: 0.7,
              magnification: 1.5,
              diameterRatio: 1.5,
            ),
            selectedIndexColor: Get.theme.colorScheme.secondary,
            builder: (context, index) {
              return Text('${5 * index}', style: Get.textTheme.titleMedium);
            },
            onIndexChanged: (index) {
              context.read<ExerciseBloc>()
                ..add(ExerciseSelectedTimeChanged(5 * index))
                ..add(ExerciseSelectedRepetitionsChanged(0));
            },
          ),
          Text('minutes', style: Get.textTheme.titleSmall),
        ],
      );
    });
  }
}
