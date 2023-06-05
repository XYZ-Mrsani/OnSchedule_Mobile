import 'package:cloud_firestore/cloud_firestore.dart';

class Bus {
  final String? id;
  final String vnum;
  final String dname;
  final String cname;
  final String phone;
  final String route;
  final String dt;
  final String at;
  final String availability;
  final String price;
  List<int> sstatus;

  Bus(
      {this.id,
      required this.vnum,
      required this.dname,
      required this.cname,
      required this.phone,
      required this.route,
      required this.dt,
      required this.at,
      required this.availability,
      required this.price,
      required this.sstatus});

  toJson() {
    return {
      "vnum": vnum,
      "dname": dname,
      "cname": cname,
      "phone": phone,
      "route": route,
      "dt": dt,
      "at": at,
      "availability": availability,
      "price": price,
      "sstatus": sstatus
    };
  }

  factory Bus.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;

    return Bus(
      id: document.id,
      vnum: data["vnum"],
      dname: data["dname"],
      cname: data["cname"],
      phone: data["phone"],
      route: data["route"],
      dt: data["dt"],
      at: data["at"],
      availability: data["availability"],
      price: data["price"],
      sstatus: List<int>.from(data["sstatus"]),
    );
  }
}
