// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import '../../utils/constants/app_constants.dart';
// import '../model/history_model.dart';
// import '../model/network_respons.dart';
//
//
// class HistoryRepository {
//
//   Future<NetworkResponse> addCard(TransactionModel transactionModel) async {
//     try {
//       DocumentReference documentReference = await FirebaseFirestore.instance
//           .collection(AppConstants.history2)
//           .add(transactionModel.toJson());
//
//       await FirebaseFirestore.instance
//           .collection(AppConstants.history2)
//           .doc(documentReference.id)
//           .update({"cardId": documentReference.id});
//
//       return NetworkResponse(data: "success");
//     } on FirebaseException catch (error) {
//       debugPrint("CARD ADD ERROR--------------:$error");
//       return NetworkResponse(errorText: error.toString());
//     }
//   }
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   Stream<List<TransactionModel>> getTransactionHistory() {
//     return _firestore.collection('history')
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//         .map((doc) => TransactionModel.fromJson(doc.data()))
//         .toList());
//   }
// }
