import 'dart:convert';

ProvinceResponse proviceResponseFromJson(String str) =>
    ProvinceResponse.fromJson(json.decode(str));
String proviceResponseToJson(ProvinceResponse data) =>
    json.encode(data.toJson());

///ProvinceResponse
class ProvinceResponse {
  ProvinceResponse({
    this.status,
    this.provinces,
  });

  ///status
  String status;

  ///provinces
  List<Province> provinces;

  factory ProvinceResponse.fromJson(Map<String, dynamic> json) =>
      ProvinceResponse(
        ///status
        status: json["status"],

        ///provinces
        provinces: List<Province>.from(
          json["results"].map((x) => Province.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "results": List<dynamic>.from(provinces.map((x) => x.toJson())),
      };
}

///Province
class Province {
  Province({
    this.code,
    this.name,
  });

  ///code
  String code;

  ///name
  String name;

  factory Province.fromJson(Map<String, dynamic> json) => Province(
        ///code
        code: json["code"],

        ///name
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}
