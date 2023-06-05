class Bookings {
  final String? id;
  final String datetime;
  final String nicnum;
  final String fname;
  final String lname;
  final String phone;
  final String from;
  final String to;
  final String seatnum;
  final String busnum;
  final String amount;
  final String time;

  const Bookings(
      {this.id,
      required this.datetime,
      required this.nicnum,
      required this.fname,
      required this.lname,
      required this.phone,
      required this.from,
      required this.to,
      required this.seatnum,
      required this.busnum,
      required this.amount,
      required this.time});

  toJson() {
    return {
      "datetime": datetime,
      "nicnum": nicnum,
      "fname": fname,
      "lname": lname,
      "phone": phone,
      "from": from,
      "to": to,
      "seatnum": seatnum,
      "busnum": busnum,
      "amount": amount,
      "time": time
    };
  }
}
