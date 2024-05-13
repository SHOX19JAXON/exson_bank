import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/history/history_bloc.dart';
import '../../../bloc/history/history_event.dart';
import '../../../bloc/history/history_state.dart';
import '../../../data/model/history_model.dart';


class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing the HistoryBloc instance
    final HistoryBloc historyBloc = BlocProvider.of<HistoryBloc>(context);

    // Dispatching an event to fetch histories
    historyBloc.add(FetchHistoriesEvent("user_id_here"));

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction History'),
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          if (state is HistoryLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HistoryLoadedState) {
            return _buildHistoryList(state.histories);
          } else if (state is HistoryErrorState) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return Container(); // Placeholder
          }
        },
      ),
    );
  }

  Widget _buildHistoryList(List<TransactionModel> histories) {
    return ListView.builder(
      itemCount: histories.length,
      itemBuilder: (context, index) {
        final history = histories[index];
        // Build UI for each transaction history item
        return ListTile(
          title: Text(history.receiverCardNumber),
          subtitle: Text(history.senderCardNumber),
          // Additional UI components as needed
        );
      },
    );
  }
}
