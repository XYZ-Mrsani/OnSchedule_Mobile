import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onschedule/models/passenger_model.dart';

class PassengerRepository extends GetxController {
  static PassengerRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createFeedback(Passenger passenger) async {
    await _db.collection('Passenger').add(passenger.toJson()).whenComplete(() {
      print("Feedback Successfully Added");
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
