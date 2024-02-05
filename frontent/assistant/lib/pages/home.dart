import 'package:assistant/logic/home/home_bloc.dart';
import 'package:assistant/logic/home/home_event.dart';
import 'package:assistant/logic/home/home_state.dart';
import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/logic/user/user_event.dart';
import 'package:assistant/model/history_item.dart';
import 'package:assistant/pages/exercise.dart';
import 'package:assistant/pages/meal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:assistant/common/buttons.dart';
import 'package:assistant/logic/user/user_bloc.dart';
import 'package:assistant/logic/user/user_state.dart';
import 'package:assistant/utils/styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        httpRepo: context.read<HttpServiceRepository>(),
        preferencesRepo: context.read<SharedPreferencesRepository>(),
      )..add(HomeInit()),
      child: Scaffold(
        backgroundColor: Get.theme.colorScheme.primary,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          minimum: Styles.contentMarginTop,
          child: Padding(
            padding: Styles.homePagePadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _homeHeader(),
                Styles.defaultVerticalSpace,
                _headerButtons(),
                Styles.defaultVerticalSpace,
                _history(),
                _menuButtons(),
                Styles.defaultVerticalSpace,
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerButtons() => BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Buttons.roundedRectangleButtonWithText(
              onPressed: () {
                context.read<HomeBloc>().add(HomeGetMealProposition());
              },
              backgroundColor: Get.theme.colorScheme.secondary,
              icon: Icons.restaurant_outlined,
              text: 'Meal proposition',
              iconColor: Get.theme.colorScheme.onSecondary,
              textColor: Get.theme.colorScheme.onSecondary,
              size: const Size(160, 50),
            ),
            Buttons.roundedRectangleButtonWithText(
              onPressed: () {
                context.read<HomeBloc>().add((HomeGetExerciseProposition()));
              },
              backgroundColor: Get.theme.colorScheme.secondary,
              icon: Icons.run_circle_outlined,
              text: 'Exercise proposition',
              iconColor: Get.theme.colorScheme.onSecondary,
              textColor: Get.theme.colorScheme.onSecondary,
              size: const Size(160, 50),
            ),
          ],
        ),
      );

  Widget _menuButtons() => BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Buttons.roundedRectangleButtonWithText(
              onPressed: () {
                Get.to(() => const LogMealPage());
              },
              backgroundColor: Get.theme.colorScheme.background,
              icon: Icons.restaurant_outlined,
              text: 'Log meal',
              iconColor: Get.theme.colorScheme.primary,
              size: const Size(160, 50),
            ),
            Buttons.roundedRectangleButtonWithText(
              onPressed: () {
                Get.to(() => const LogExcercisePage());
              },
              backgroundColor: Get.theme.colorScheme.background,
              icon: Icons.run_circle_outlined,
              text: 'Log exercise',
              iconColor: Get.theme.colorScheme.primary,
              size: const Size(160, 50),
            ),
          ],
        ),
      );

  Widget _history() => BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your history',
                  style: Get.theme.textTheme.titleLarge?.copyWith(
                    color: Get.theme.colorScheme.onPrimary,
                  ),
                ),
                // history
                state.historyItems.isEmpty
                    ? Text(
                        'No past activities',
                        style: Get.theme.textTheme.titleSmall?.copyWith(
                          color: Get.theme.colorScheme.secondary,
                        ),
                      )
                    : Column(
                        children: [
                          Styles.defaultVerticalSpace,
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: ListView.builder(
                              itemCount: state.historyItems.length,
                              itemBuilder: (context, index) => _historyItem(
                                historyItem: state.historyItems[index],
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          );
        },
      );

  Widget _historyItem({required HistoryItem historyItem}) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                historyItem.type.name,
                style: Get.theme.textTheme.bodyLarge?.copyWith(
                  color: Get.theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                DateFormat('dd MMMM yyyy').format(historyItem.date),
                style: Get.theme.textTheme.bodyLarge?.copyWith(
                  color: Get.theme.colorScheme.secondary,
                ),
              ),
            ],
          ),
          Text(
            historyItem.name,
            style: Get.theme.textTheme.bodyMedium?.copyWith(
              color: Get.theme.colorScheme.onPrimary,
            ),
          ),
          Divider(
            color: Get.theme.colorScheme.secondary,
            thickness: 1,
          ),
          Styles.defaultVerticalSpace,
        ],
      );

  Widget _homeHeader() => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, ${state.name}',
                  style: Get.theme.textTheme.headlineSmall
                      ?.copyWith(color: Get.theme.colorScheme.onPrimary),
                ),
                StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Text(
                      DateFormat('dd MMMM yyyy, HH:mm:ss')
                          .format(DateTime.now()),
                      style: Get.theme.textTheme.bodyLarge?.copyWith(
                          color: Get.theme.colorScheme.secondary,
                          fontWeight: FontWeight.w700),
                    );
                  },
                )
              ],
            ),
            Buttons.roundedRectangleButton(
              onPressed: () {
                context.read<UserBloc>().add(UserLogout());
              },
              backgroundColor: Get.theme.colorScheme.secondary,
              icon: Icons.logout,
              iconColor: Get.theme.colorScheme.onPrimary,
              size: const Size(50, 50),
            ),
          ],
        ),
      );
}
