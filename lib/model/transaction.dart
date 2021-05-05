///Note file transaction.dart

///Describe transaction (room ID, user ID, check in, check out, room number, create day, total money)
class Transactions {
  ///id Room
  String idRoom;

  ///id
  String id;

  ///Check in
  String checkIn;

  ///id User
  String idUser;

  ///Check out
  String checkOut;

  ///Create day
  String createDay;

  ///Night
  int night;

  ///Status
  int status;

  ///Number room
  int numberRoom;

  ///Total money
  double totalMoney;

  Transactions({
    this.idRoom,
    this.id,
    this.checkIn,
    this.idUser,
    this.checkOut,
    this.createDay,
    this.night,
    this.status,
    this.numberRoom,
    this.totalMoney,
  });

  factory Transactions.formJson(Map<String, dynamic> json, String id) =>
      Transactions(
        ///idRoom
        idRoom: json['id_room'],

        ///id
        id: id,

        ///checkIn
        checkIn: json["check_in"],

        ///idUser
        idUser: json["id_user"],

        ///checkOut
        checkOut: json["check_out"],

        ///createDay
        createDay: json["create_day"],

        ///night
        night: json["night"],

        ///status
        status: json["status"] ?? 0,

        ///numberRoom
        numberRoom: json['number_room'],

        ///totalMoney
        totalMoney: json['total_price'],
      );
}
