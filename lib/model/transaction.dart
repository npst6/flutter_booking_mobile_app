///Note file transaction.dart

///Describe transaction (room ID, user ID, check in, check out, room number, create day, total money)
class Transactions {
  String idRoom;    String id; String checkIn; String idUser; String checkOut;
  String createDay; int night; int status;    int numberRoom; double totalMoney;

  Transactions({
    this.idRoom,    this.id,    this.checkIn, this.idUser,      this.checkOut,
    this.createDay, this.night, this.status,  this.numberRoom,  this.totalMoney,
  });

  ///
  factory Transactions.formJson(Map<String, dynamic> json, String id) =>
      Transactions(
        idRoom      : json['id_room'],
        id          : id,
        checkIn     : json["check_in"],
        idUser      : json["id_user"],
        checkOut    : json["check_out"],
        createDay   : json["create_day"],
        night       : json["night"],
        status      : json["status"] ?? 0,
        numberRoom  : json['number_room'],
        totalMoney  : json['total_price'],
      );
}
