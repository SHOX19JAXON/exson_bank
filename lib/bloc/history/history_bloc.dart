
import 'package:bloc/bloc.dart';

import '../../data/repositories/history2.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoriesRepository repository;

  HistoryBloc({required this.repository}) : super(HistoryLoadingState()) {
    on<AddHistoryEvent>((event, emit) {
      _mapAddHistoryEventToState(event, emit);
    });

    on<FetchHistoriesEvent>((event, emit) {
      _mapFetchHistoriesEventToState(event, emit);
    });
  }

  void _mapAddHistoryEventToState(AddHistoryEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoadingState());
    try {
      final response = await repository.addHistory(event.historyModel);
      if (response.data == "success") {
        emit(HistoryLoadedState([]));
      } else {
        emit(HistoryErrorState("Failed to add history"));
      }
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
    }
  }

  void _mapFetchHistoriesEventToState(FetchHistoriesEvent event, Emitter<HistoryState> emit) async {
    emit(HistoryLoadingState());
    try {
      final histories = await repository.getHistoriesByUserId(event.userId).first;
      emit(HistoryLoadedState(histories));
    } catch (e) {
      emit(HistoryErrorState(e.toString()));
    }
  }
}
