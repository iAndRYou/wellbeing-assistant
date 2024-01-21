import 'package:flutter/material.dart';
import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
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
  final sheetKey = GlobalKey<ExpandableBottomSheetState>();

  final sheetHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.colorScheme.primary,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        minimum: Styles.contentMarginTop,
        child: ExpandableBottomSheet(
          key: sheetKey,
          enableToggle: true,
          persistentContentHeight: MediaQuery.of(context).size.height * 0.5 -
              MediaQuery.of(context).padding.top -
              280,
          background: Stack(
            children: [
              Padding(
                padding: Styles.homePagePadding,
                child: Column(
                  children: [
                    _homeHeader(),
                    Styles.defaultVerticalSpace,
                    _searchField(),
                    _favourite(),
                  ],
                ),
              ),
            ],
          ),
          persistentHeader: _sheetHeader(),
          expandableContent: _sheetContent(),
        ),
      ),
    );
  }

  Widget _searchField() => TextField(
        style: Get.theme.textTheme.bodyLarge
            ?.copyWith(color: Get.theme.colorScheme.onPrimary),
        cursorColor: Get.theme.colorScheme.onPrimary,
        decoration: Styles.searchInputDecoration(
          label: 'Search',
          labelColor: Get.theme.colorScheme.onPrimary,
          fillColor: Get.theme.colorScheme.secondary,
        ),
        onTap: () => sheetKey.currentState?.expand(),
      );

  Widget _sheetContent() => Container(
        height: MediaQuery.of(context).size.height -
            MediaQuery.of(context).padding.top -
            240,
        color: Get.theme.colorScheme.onPrimary,
      );

  Widget _sheetHeader() => Container(
        height: sheetHeight,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.onPrimary,
          borderRadius: const BorderRadius.only(
            topLeft: Styles.wideRadius,
            topRight: Styles.wideRadius,
          ),
        ),
        child: Center(
          child: Container(
            height: 5,
            width: 50,
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.secondary,
              borderRadius: Styles.wideBorderRadius,
            ),
          ),
        ),
      );

  Widget _favourite() => BlocBuilder<UserBloc, UserState>(
        builder: (context, state) => Container(
          height: MediaQuery.of(context).size.height * 0.5,
          margin: Styles.contentMarginTop,
          child: state.hasDevices
              //TODO: favoutite
              ? const SizedBox()
              : _noDevicesMessage(),
        ),
      );

  Widget _noDevicesMessage() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You have no added stations',
            style: Get.theme.textTheme.headlineSmall?.copyWith(
              color: Get.theme.colorScheme.onPrimary,
            ),
          ),
          //TODO: add station
          TextButton(
            onPressed: () {},
            child: Text(
              'Click here to add your station',
              style: Get.theme.textTheme.titleLarge?.copyWith(
                  color: Get.theme.colorScheme.secondary,
                  fontWeight: FontWeight.w700),
            ),
          ),
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
                  'Hi, ${state.username}',
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
              onPressed: () {},
              backgroundColor: Get.theme.colorScheme.secondary,
              icon: Icons.settings,
              iconColor: Get.theme.colorScheme.onPrimary,
              size: const Size(50, 50),
            ),
          ],
        ),
      );
}
