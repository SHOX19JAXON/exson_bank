// Define states
import '../../data/model/history_model.dart';

abstract class HistoryState {}

class HistoryLoadingState extends HistoryState {}

class HistoryLoadedState extends HistoryState {



  final List<TransactionModel> histories;

  HistoryLoadedState(this.histories);
}

class HistoryErrorState extends HistoryState {
  final String error;

  HistoryErrorState(this.error);
}