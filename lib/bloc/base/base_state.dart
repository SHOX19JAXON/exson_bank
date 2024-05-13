import 'package:equatable/equatable.dart';

import '../../data/model/forma_stats.dart';


class BaseState extends Equatable {
  final FormsStatus status;
  final String errorMessage;
  final String statusMessage;

  const BaseState({
    required this.status,
    required this.errorMessage,
    required this.statusMessage,
  });


  @override
  List<Object?> get props => [
        status,
        errorMessage,
        statusMessage,
      ];
}
