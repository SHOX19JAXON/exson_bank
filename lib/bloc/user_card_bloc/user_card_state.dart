
import 'package:equatable/equatable.dart';

import '../../data/model/card_model.dart';
import '../../data/model/forma_stats.dart';

class UserCardsState extends Equatable {
  const UserCardsState(
      {required this.userCards,
        required this.formStatus,
        required this.errorMessage,
        required this.statusMessage,
        required this.userCardsDB});

  final List<CardModel> userCards;
  final List<CardModel> userCardsDB;
  final FormStatus formStatus;
  final String errorMessage;
  final String statusMessage;

  UserCardsState copyWith({
    List<CardModel>? userCards,
    List<CardModel>? userCardsDB,
    FormStatus? formStatus,
    String? errorMessage,
    String? statusMessage,
  }) {
    return UserCardsState(
      userCards: userCards ?? this.userCards,
      formStatus: formStatus ?? this.formStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      statusMessage: statusMessage ?? this.statusMessage,
      userCardsDB: userCardsDB ?? this.userCardsDB,
    );
  }

  @override
  List<Object?> get props => [
    userCards,
    formStatus,
    errorMessage,
    statusMessage,
    userCardsDB,
  ];
}