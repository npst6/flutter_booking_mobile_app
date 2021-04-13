///Note file room.dart

/// Describe room (room ID, room name, start date book room, end date book room, room status,
/// room number, adults number in room, children number in room, address, city, discount, money,)
class Room {
  String nameRoom;
  String idRoom;
  String startDay;
  String endDay;
  int numberRoom;
  int numberAdults;
  int numberChild;
  String address;
  String city;
  double discount;
  String desc;
  int status;
  String createDay;
  double money;
  String idHotel;
  String urlImage;
  List<int> service;

  Room({
    this.nameRoom,
    this.idRoom,
    this.startDay,
    this.endDay,
    this.numberRoom,
    this.numberAdults,
    this.numberChild,
    this.address,
    this.city,
    this.discount,
    this.desc,
    this.status,
    this.createDay,
    this.money,
    this.idHotel,
    this.urlImage,
    this.service,
  });

  factory Room.formJson(Map<String, dynamic> json, String id) => Room(
        nameRoom: json["name_room"],
        idRoom: id,
        startDay: json["start_day"] ?? DateTime.now().millisecondsSinceEpoch,
        endDay: json["end_day"] ?? DateTime.now().millisecondsSinceEpoch,
        numberRoom: json['number_room'] ?? 0,
        numberAdults: json['number_adults'],
        numberChild: json['number_child'],
        address: json['address'] ?? "",
        city: json['city'] ?? "",
        discount: json['discount'],
        desc: json['desc'],
        status: json['status'],
        createDay: json['create_day'] ?? DateTime.now().toIso8601String(),
        money: json["money"],
        idHotel: json["id_hotel"],
        urlImage: json["url_image"],
        service: json['service'].cast<int>(),
      );
}
