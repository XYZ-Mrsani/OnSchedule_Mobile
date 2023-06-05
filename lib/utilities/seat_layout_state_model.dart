import 'package:book_my_seat/book_my_seat.dart';

class SeatLayoutStateModel {
  final int rows;
  final int cols;
  final double seatSvgSize;
  final String pathSelectedSeat;
  final String pathDisabledSeat;
  final String pathSoldSeat;
  final String pathUnSelectedSeat;
  final List<List<SeatState>> currentSeatsState;
  final List<List<String>> seatNumbers; // new argument for seat numbers

  const SeatLayoutStateModel({
    required this.rows,
    required this.cols,
    required this.seatSvgSize,
    required this.pathSelectedSeat,
    required this.pathDisabledSeat,
    required this.pathSoldSeat,
    required this.pathUnSelectedSeat,
    required this.currentSeatsState,
    required this.seatNumbers, // added argument
  });
}

const seatLayout = SeatLayoutStateModel(
  rows: 14,
  cols: 6,
  seatSvgSize: 45,
  pathSelectedSeat: 'images/seat_selected.svg',
  pathDisabledSeat: 'images/seat_disabled.svg',
  pathSoldSeat: 'images/seat_sold.svg',
  pathUnSelectedSeat: 'images/seat_unselected.svg',
  currentSeatsState: [
    [
      //SeatState.disabled,
      SeatState.unselected,
      SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.unselected,
      SeatState.unselected,
    ],
    [
      //SeatState.unselected,
      SeatState.unselected,
      SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.unselected,
      SeatState.unselected,
    ],
    [
      //SeatState.unselected,
      SeatState.unselected,
      SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.sold,
      SeatState.unselected,
    ],
    [
      //SeatState.unselected,
      SeatState.unselected,
      SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.sold,
      SeatState.unselected,
    ],
    [
      //SeatState.unselected,
      SeatState.unselected,
      SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.sold,
      SeatState.unselected,
    ],
    [
      //SeatState.unselected,
      SeatState.unselected,
      SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.sold,
      SeatState.unselected,
    ],
    [
      //SeatState.unselected,
      SeatState.unselected,
      SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.sold,
      SeatState.unselected,
    ],
    [
      //SeatState.unselected,
      SeatState.unselected,
      SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.sold,
      SeatState.unselected,
    ],
    [
      //SeatState.sold,
      SeatState.unselected,
      SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.unselected,
      SeatState.unselected,
    ],
    [
      //SeatState.unselected,
      SeatState.unselected,
      SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.unselected,
      SeatState.unselected,
    ],
    [
      //SeatState.sold,
      SeatState.sold,
      SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.unselected,
      SeatState.unselected,
    ],
    [
      //SeatState.empty,
      SeatState.empty,
      SeatState.empty,
      SeatState.empty,
      SeatState.empty,
      SeatState.unselected,
      SeatState.unselected,
    ],
    [
      //SeatState.unselected,
      SeatState.empty,
      SeatState.empty,
      SeatState.empty,
      SeatState.empty,
      SeatState.unselected,
      SeatState.unselected,
    ],
    [
      //SeatState.unselected,
      SeatState.unselected,
      SeatState.sold,
      SeatState.sold,
      SeatState.unselected,
      SeatState.unselected,
      SeatState.unselected,
    ],
  ],
  seatNumbers: [
    ['01', '02', '', '', '03', '04'],
    ['05', '06', '', '', '07', '08'],
    ['09', '10', '', '', '11', '12'],
    ['13', '14', '', '', '15', '16'],
    ['17', '18', '', '', '19', '20'],
    ['21', '22', '', '', '23', '24'],
    ['25', '26', '', '', '27', '28'],
    ['29', '30', '', '', '31', '32'],
    ['33', '34', '', '', '35', '36'],
    ['37', '38', '', '', '39', '40'],
    ['41', '42', '', '', '43', '44'],
    ['', '', '', '', '45', '46'],
    ['', '', '', '', '47', '48'],
    ['49', '50', '51', '52', '53', '54'],
  ],
);
