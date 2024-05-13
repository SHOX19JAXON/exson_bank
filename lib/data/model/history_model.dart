import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String senderCardNumber;
  final String receiverCardNumber;
  final double amount;
  final DateTime timestamp;

  TransactionModel({
    required this.id,
    required this.senderCardNumber,
    required this.receiverCardNumber,
    required this.amount,
    required this.timestamp,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] ?? '',
      senderCardNumber: json['senderCardNumber'] ?? '',
      receiverCardNumber: json['receiverCardNumber'] ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      timestamp: (json['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderCardNumber': senderCardNumber,
      'receiverCardNumber': receiverCardNumber,
      'amount': amount,
      'timestamp': timestamp,
    };
  }

  factory TransactionModel.initial() {
    return TransactionModel(
      id: '',
      amount: 0.0,
      timestamp: DateTime.now(),
      senderCardNumber: '',
      receiverCardNumber: '',
    );
  }
}
