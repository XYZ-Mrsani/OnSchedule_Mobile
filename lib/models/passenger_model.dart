class Passenger {
  final String? id;
  final String pname;
  final String datetime;
  final String feedback;
  final String busnum;
  final String busroute;

  const Passenger({
    this.id,
    required this.pname,
    required this.datetime,
    required this.feedback,
    required this.busnum,
    required this.busroute,
  });

  toJson() {
    return {
      "pname": pname,
      "datetime": datetime,
      "feedback": feedback,
      "busnum": busnum,
      "busroute": busroute,
    };
  }
}
