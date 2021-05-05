///Note file room.dart

///Describe room (room ID, room name, start date book room, end date book room, room status,
///room number, adults number in room, children number in room, address, city, discount, money,)
class Room {
  ///nameRoom
  String nameRoom;

  ///idRoom
  String idRoom;

  ///startDay
  String startDay;

  ///endDay
  String endDay;

  ///numberRoom
  int numberRoom;

  ///numberAdults
  int numberAdults;

  ///numberChild
  int numberChild;

  ///address
  String address;

  ///city
  String city;

  ///discount
  double discount;

  ///desc
  String desc;

  ///status
  int status;

  ///createDay
  String createDay;

  ///money
  double money;

  ///idHotel
  String idHotel;

  ///urlImage
  String urlImage;

  ///service
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
        ///nameRoom
        nameRoom: json["name_room"],

        ///idRoom
        idRoom: id,

        ///startDay
        startDay: json["start_day"] ?? DateTime.now().millisecondsSinceEpoch,

        ///endDay
        endDay: json["end_day"] ?? DateTime.now().millisecondsSinceEpoch,

        ///numberRoom
        numberRoom: json['number_room'] ?? 0,

        ///numberAdults
        numberAdults: json['number_adults'],

        ///numberChild
        numberChild: json['number_child'],

        ///address
        address: json['address'] ?? "",

        ///city
        city: json['city'] ?? "",

        ///discount
        discount: json['discount'],

        ///desc
        desc: json['desc'],

        ///status
        status: json['status'],

        ///createDay
        createDay: json['create_day'] ?? DateTime.now().toIso8601String(),

        ///money
        money: json["money"],

        ///idHotel
        idHotel: json["id_hotel"],

        ///urlImage
        urlImage: json["url_image"],

        ///service
        service: json['service'].cast<int>(),
      );
}
