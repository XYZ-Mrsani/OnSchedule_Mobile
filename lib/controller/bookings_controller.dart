import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:onschedule/models/bookings_model.dart';
import 'package:onschedule/repository/bookings_repository.dart';

class BookingsController extends GetxController {
  static BookingsController get instance => Get.find();

  final nic_txt = TextEditingController();
  final fname_txt = TextEditingController();
  final lname_txt = TextEditingController();
  final phone_txt = TextEditingController();

  final bookingsRepo = Get.put(BookingsRepository());

  Future<void> createBooking(Bookings bookings) async {
    await bookingsRepo.createBooking(bookings);
  }
}
