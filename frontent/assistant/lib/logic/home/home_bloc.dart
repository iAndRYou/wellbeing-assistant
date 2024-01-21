import 'package:assistant/logic/home/home_event.dart';
import 'package:assistant/logic/home/home_state.dart';
import 'package:assistant/logic/http_repo.dart';
import 'package:assistant/logic/preferences_repo.dart';
import 'package:assistant/model/history_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HttpServiceRepository httpRepo;
  final SharedPreferencesRepository preferencesRepo;
  HomeBloc({required this.httpRepo, required this.preferencesRepo})
      : super(HomeState()) {
    on<HomeInit>((event, emit) async {
      var accessToken = await preferencesRepo.getSavedAccessToken();

      List<HistoryItem> historyItems =
          await httpRepo.getUserHistory(accessToken: accessToken);

      emit(state.copyWith(historyItems: historyItems));
    });

    on<HomeUpdate>((event, emit) async {
      var accessToken = await preferencesRepo.getSavedAccessToken();

      List<HistoryItem> historyItems =
          await httpRepo.getUserHistory(accessToken: accessToken);

      emit(state.copyWith(historyItems: historyItems));
    });
  }
}
