
// Define events
import '../../data/model/history_model.dart';

abstract class HistoryEvent {}

class AddHistoryEvent extends HistoryEvent {
  final TransactionModel historyModel;

  AddHistoryEvent({required this.historyModel});
}

class FetchHistoriesEvent extends HistoryEvent {
  final String userId;

  FetchHistoriesEvent(this.userId);
}