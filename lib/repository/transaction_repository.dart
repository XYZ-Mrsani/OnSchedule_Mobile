import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/transaction_model.dart';

class TransactionRepository extends GetxController {
  static TransactionRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createTransaction(Transactions transactions) async {
    await _db
        .collection('Transaction')
        .add(transactions.toJson())
        .whenComplete(() {
      print("Transaction Successfully Added");
    }).catchError((error, stackTrace) {
      Get.snackbar("Error", "Something Went Wrong",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print(error.toString());
      return Future.error(error);
    });
  }
}
