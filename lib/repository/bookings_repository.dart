import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onschedule/models/bookings_model.dart';

class BookingsRepository extends GetxController {
  static BookingsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createBooking(Bookings bookings) async {
    await _db.collection('Bookings').add(bookings.toJson()).whenComplete(() {
      print("Booking Successfully Added");
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
