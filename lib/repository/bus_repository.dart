import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/bus_model.dart';

class BusRepository extends GetxController {
  static BusRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<Bus> getBusDetails(route) async {
    final snapshot =
        await _db.collection("Bus").where("route", isEqualTo: route).get();
    final busData = snapshot.docs.map((e) => Bus.fromSnapshot(e)).single;
    return busData;
  }

  Future<List<Bus>> getAllBusDetails(String route) async {
    final snapshot =
        await _db.collection("Bus").where("route", isEqualTo: route).get();
    final busData = snapshot.docs.map((e) => Bus.fromSnapshot(e)).toList();
    return busData;
  }

  Future<Bus> getSelectedBusDetails(String route, String busnum) async {
    final snapshot = await _db
        .collection("Bus")
        .where("route", isEqualTo: route)
        .where("vnum", isEqualTo: busnum)
        .get();
    final busData = snapshot.docs.map((e) => Bus.fromSnapshot(e)).single;
    return busData;
  }

  Future<void> updateBusseats(String vnum, List<int> sstatus) async {
    final snapshot =
        await _db.collection("Bus").where('vnum', isEqualTo: vnum).get();

    final busData = snapshot.docs.map((e) => Bus.fromSnapshot(e)).single;

    busData.sstatus = sstatus;

    await _db.collection("Bus").doc(busData.id).update(busData.toJson());
  }
}
