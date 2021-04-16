///Note file account.dart

///Describe account (Email, phone, name, create day, avatar)
class Account {
  ///email
  String email;

  ///phone
  String phone;

  ///name
  String name;

  ///uid
  String uid;

  ///isActive
  int isActive;

  ///permission
  int permission;

  ///createDay
  int createDay;

  ///avatar
  String avatar;

  Account({
    this.email,
    this.phone,
    this.name,
    this.uid,
    this.isActive,
    this.permission,
    this.createDay,
    this.avatar,
  });

  factory Account.formJson(Map<String, dynamic> json, String uid) => Account(
        ///email
        email: json['email'],

        ///phone
        phone: json["phone"],

        ///name
        name: json["name"],

        ///uid
        uid: uid,

        ///isActive
        isActive: json['isActive'],

        ///permission
        permission: json['permission'],

        ///createDay
        createDay: json['create_day'] ?? DateTime.now().millisecondsSinceEpoch,

        ///avatar
        avatar: json['avatar'] ?? "",
      );
}
