///Note file account.dart

///Describe account (Email, phone, name, create day, avatar)
class Account {
  String email; String phone; String name; String uid;
  int isActive; int permission; int createDay; String avatar;

  Account ({
    this.email, this.phone, this.name, this.uid,
    this.isActive, this.permission, this.createDay, this.avatar,
  });

  ///
  factory Account.formJson (Map < String, dynamic > json, String uid) => Account (
    email:      json['email'],
    phone:      json["phone"],
    name:       json["name"],
    uid:        uid,
    isActive:   json['isActive'],
    permission: json['permission'],
    createDay:  json['create_day'] ?? DateTime.now().millisecondsSinceEpoch,
    avatar:     json['avatar'] ?? "",
  );
}