import 'package:get/get.dart';
import 'package:onschedule/models/bus_model.dart';
import 'package:onschedule/repository/bus_repository.dart';

class BusController extends GetxController {
  static BusController get instance => Get.find();

  final _busRepo = Get.put(BusRepository());

  getBusData(String route) {
    // const route = 'Kandy - Colombo';
    if (route != null) {
      return _busRepo.getBusDetails(route);
    } else {
      Get.snackbar("Error", "Not fetch the data");
    }
  }

  getSelectedBusData(String route, String vnum) {
    // const route = 'Kandy - Colombo';
    if (route != null) {
      return _busRepo.getSelectedBusDetails(route, vnum);
    } else {
      Get.snackbar("Error", "Not fetch the data");
    }
  }

  Future<List<Bus>> getAllUser(String route) async {
    return await _busRepo.getAllBusDetails(route);
  }

  Future<void> updateBusSeatsStatus(String vnum, List<int> seatStatus) async {
    await _busRepo.updateBusseats(vnum, seatStatus);
  }
}
