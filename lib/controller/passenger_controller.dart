import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:onschedule/repository/passenger_repository.dart';

import '../models/passenger_model.dart';

class PassengerController extends GetxController {
  static PassengerController get instance => Get.find();

  final pname_txt = TextEditingController();
  final feedback_txt = TextEditingController();

  final feedbackRepo = Get.put(PassengerRepository());

  Future<void> createFeedback(Passenger passenger) async {
    await feedbackRepo.createFeedback(passenger);
  }
}
