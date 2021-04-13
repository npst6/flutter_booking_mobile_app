import 'dart:convert';

ProvinceResponse proviceResponseFromJson(String str) =>
    ProvinceResponse.fromJson(json.decode(str));
String proviceResponseToJson(ProvinceResponse data) =>
    json.encode(data.toJson());

class ProvinceResponse {
  ProvinceResponse({
    this.status,
    this.provinces,
  });
  String status;
  List<Province> provinces;
  factory ProvinceResponse.fromJson(Map<String, dynamic> json) =>
      ProvinceResponse(
        status: json["status"],
        provinces: List<Province>.from(
          json["results"].map((x) => Province.fromJson(x)),
        ),
      );
  Map<String, dynamic> toJson() => {
        "status": status,
        "results": List<dynamic>.from(provinces.map((x) => x.toJson())),
      };
}

class Province {
  Province({
    this.code,
    this.name,
  });
  String code;
  String name;
  factory Province.fromJson(Map<String, dynamic> json) => Province(
        code: json["code"],
        name: json["name"],
      );
  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}
