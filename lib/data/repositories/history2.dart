


import 'package:rxdart/rxdart.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../../utils/constants/app_constants.dart';
import '../model/history_model.dart';
import '../model/network_respons.dart';

class HistoriesRepository {
  Future<NetworkResponse> addHistory(TransactionModel historyModel) async {
    try {


      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection(AppConstants.histories)
          .add(historyModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.histories)
          .doc(documentReference.id)
          .update({"docId": documentReference.id});

      return NetworkResponse(data: "success");
    } on FirebaseException catch (error) {
      debugPrint("HISTORY ADD ERROR:$error");
      debugPrint("KIRMaDIIIIIIIIIIIIIII");

      return NetworkResponse(errorText: error.toString());
    }
  }

  Stream<List<TransactionModel>> getHistoriesByUserId(String docId) {
    Stream<List<TransactionModel>> senderHistories = FirebaseFirestore.instance
        .collection(AppConstants.histories)
        .where("senderId", isEqualTo: docId)
        .snapshots()
        .map((event) =>
        event.docs.map((doc) => TransactionModel.fromJson(doc.data())).toList());

    Stream<List<TransactionModel>> receiverHistories = FirebaseFirestore.instance
        .collection(AppConstants.histories)
        .where("receiverId", isEqualTo: docId)
        .snapshots()
        .map((event) =>
        event.docs.map((doc) => TransactionModel.fromJson(doc.data())).toList());

    return CombineLatestStream<List<TransactionModel>, List<TransactionModel>>(
        [senderHistories, receiverHistories], (list) => list.expand((element) => element).toList());
  }

}

