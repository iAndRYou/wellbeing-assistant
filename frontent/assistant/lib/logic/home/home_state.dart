import 'package:assistant/model/history_item.dart';

class HomeState {
  final List<HistoryItem> historyItems;

  HomeState({
    this.historyItems = const [],
  });

  HomeState copyWith({
    List<HistoryItem>? historyItems,
  }) {
    return HomeState(
      historyItems: historyItems ?? this.historyItems,
    );
  }
}
