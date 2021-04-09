///Note file transaction.dart

/// Describe transaction ( room ID, user ID, check in, check out, room number, create day, total money )
class Transactions {String idRoom; String idUser; String checkIn; String checkOut;
                    int night; String id; int status; int numberRoom; String createDay; double totalMoney;

  Transactions({this.idRoom, this.checkIn, this.checkOut, this.night, this.id,
                this.idUser, this.createDay, this.status, this.numberRoom, this.totalMoney});

  ///
  factory Transactions.formJson(Map<String, dynamic> json, String id) =>
      Transactions(
        idRoom: json['id_room'],
        id: id,
        checkIn: json["check_in"],
        idUser: json["id_user"],
        checkOut: json["check_out"],
        createDay: json["create_day"],
        night: json["night"],
        status: json["status"] ?? 0,
        numberRoom: json['number_room'],
        totalMoney: json['total_price'],
      );
}
