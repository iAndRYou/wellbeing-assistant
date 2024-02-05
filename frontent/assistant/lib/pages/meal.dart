import 'package:assistant/common/buttons.dart';
import 'package:assistant/common/meal.dart';
import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/logic/meal/meal_bloc.dart';
import 'package:assistant/logic/meal/meal_event.dart';
import 'package:assistant/logic/meal/meal_state.dart';
import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/logic/user/user_bloc.dart';
import 'package:assistant/logic/user/user_event.dart';
import 'package:assistant/model/meal.dart';
import 'package:assistant/pages/home.dart';
import 'package:assistant/utils/enums.dart';
import 'package:assistant/utils/styles.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:wheel_picker/wheel_picker.dart';

class LogMealPage extends StatelessWidget {
  const LogMealPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealBloc(
        httpServiceRepo: context.read<HttpServiceRepository>(),
        sharedPreferencesRepo: context.read<SharedPreferencesRepository>(),
      )..add(MealInit()),
      child: BlocBuilder<MealBloc, MealState>(builder: (context, state) {
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
                  Text('Choose meals you had', style: Get.textTheme.titleLarge),
                  Styles.defaultVerticalSpace,
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          _selectPrepared(),
                          _selectSimple(),
                          _selectedMeals(),
                        ],
                      ),
                    ),
                  ),
                  Styles.defaultVerticalSpace,
                  Buttons.roundedRectangleButton(
                    onPressed: state.hasAllSelected
                        ? () {
                            context.read<MealBloc>().add(MealSubmit());
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

  Widget _selectPrepared() {
    return BlocBuilder<MealBloc, MealState>(builder: (context, state) {
      return DropdownSearch<Meal>.multiSelection(
        items: state.preparedMeals,
        itemAsString: (dish) => dish.name,
        onChanged: (dishes) {
          context.read<MealBloc>().add(MealSelectMeals(dishes));
        },
        filterFn: (item, filter) =>
            item.name.toLowerCase().contains(filter.toLowerCase()),
        popupProps: PopupPropsMultiSelection.menu(
          showSearchBox: true,
          searchDelay: const Duration(milliseconds: 100),
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.name),
            leading: Icon(
              Icons.local_restaurant,
              color: Get.theme.colorScheme.primary,
            ),
          ),
          selectionWidget: ((context, item, isSelected) => isSelected
              ? const Padding(
                  padding: Styles.defaultPadding,
                  child: Icon(Icons.check),
                )
              : const Padding(
                  padding: Styles.defaultPadding,
                  child: Icon(Icons.add),
                )),
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
              label: Text('Select prepared dishes',
                  style: Get.textTheme.titleSmall),
              border: InputBorder.none),
        ),
      );
    });
  }

  Widget _selectSimple() {
    return BlocBuilder<MealBloc, MealState>(builder: (context, state) {
      return DropdownSearch<Meal>.multiSelection(
        items: state.ingredients,
        itemAsString: (dish) => dish.name,
        onChanged: (dishes) {
          context.read<MealBloc>().add(MealSelectIngredients(dishes));
        },
        filterFn: (item, filter) =>
            item.name.toLowerCase().contains(filter.toLowerCase()),
        popupProps: PopupPropsMultiSelection.menu(
          showSearchBox: true,
          searchDelay: const Duration(milliseconds: 100),
          itemBuilder: (context, item, isSelected) => ListTile(
            title: Text(item.name),
            leading: Icon(
              Icons.cookie,
              color: Get.theme.colorScheme.primary,
            ),
          ),
          selectionWidget: ((context, item, isSelected) => isSelected
              ? const Padding(
                  padding: Styles.defaultPadding,
                  child: Icon(Icons.check),
                )
              : const Padding(
                  padding: Styles.defaultPadding,
                  child: Icon(Icons.add),
                )),
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
              label: Text('Select side dishes / snacks',
                  style: Get.textTheme.titleSmall),
              border: InputBorder.none),
        ),
      );
    });
  }

  Widget _selectedMeals() {
    return BlocBuilder<MealBloc, MealState>(builder: (context, state) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: state.hasSelected
            ? Expanded(
                child: ListView.builder(
                  itemCount: state.allSelected.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  state.allSelected[index].mealType ==
                                          MealType.preparedMeal
                                      ? Icons.local_restaurant
                                      : Icons.cookie,
                                  color: Get.theme.colorScheme.primary,
                                ),
                                Styles.defaultHorizontalSpace,
                                Text(
                                  state.allSelected[index].name,
                                  style: Get.textTheme.titleMedium,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                WheelPicker(
                                  itemCount: 51,
                                  looping: false,
                                  style: const WheelPickerStyle(
                                    size: 80,
                                    itemExtent: 30,
                                    surroundingOpacity: 0.7,
                                    magnification: 1.5,
                                    diameterRatio: 1.5,
                                  ),
                                  selectedIndexColor:
                                      Get.theme.colorScheme.secondary,
                                  builder: (context, wheelIndex) {
                                    return Text('${10 * wheelIndex}',
                                        style: Get.textTheme.titleMedium);
                                  },
                                  onIndexChanged: (wheelIndex) {
                                    context.read<MealBloc>().add(MealEditWeight(
                                        state.allSelected[index],
                                        10 * wheelIndex));
                                  },
                                ),
                                Text('grams', style: Get.textTheme.titleSmall),
                              ],
                            ),
                          ],
                        ),
                        Styles.defaultVerticalSpace,
                        mealScores(state.allSelected[index]),
                        mealNutriens(state.allSelected[index]),
                        const Divider()
                      ],
                    );
                  },
                ),
              )
            : Center(
                child: Text(
                  'No meals selected',
                  style: Get.textTheme.titleSmall,
                ),
              ),
      );
    });
  }
}
