import 'package:cloud_firestore/cloud_firestore.dart';

class Transactions {
  final String? id;
  final String datetime;
  final String amount;
  final String nicnum;
  final String pname;
  final String busnum;
  final String dt;
  final String at;
  final String destination;

  const Transactions(
      {this.id,
      required this.datetime,
      required this.amount,
      required this.nicnum,
      required this.pname,
      required this.busnum,
      required this.at,
      required this.dt,
      required this.destination});

  toJson() {
    return {
      "datetime": datetime,
      "amount": amount,
      "nicnum": nicnum,
      "pname": pname,
      "busnum": busnum,
      "dt": dt,
      "at": at,
      "destination": destination
    };
  }
}
