///Note file my_home_stay.dart

///Describe MyHomeStay (Name, phone, create day, image, name account bank, number account bank, name bank of shop)
class MyHomeStay {
  ///Name
  String name;

  ///Phone
  String phone;

  ///List reviews
  List<int> listReviews;

  ///Create day
  String createDay;

  ///Status
  int status;

  ///Url image
  String urlImage;

  ///Account name bank
  String accountNameBank;

  ///Bank number
  String bankNumber;

  ///Bank name
  String bankName;

  MyHomeStay({
    this.name,
    this.phone,
    this.listReviews,
    this.createDay,
    this.status,
    this.urlImage,
    this.accountNameBank,
    this.bankNumber,
    this.bankName,
  });

  factory MyHomeStay.formJson(Map<String, dynamic> json) => MyHomeStay(
        ///name
        name: json['name'],

        ///phone
        phone: json['phone'],

        ///listReviews
        listReviews: json['list_review'].cast<int>() ?? [].cast<int>(),

        ///createDay
        createDay: json["create_day"],

        ///status
        status: json["status"] ?? 1,

        ///urlImage
        urlImage: json["url_image"],

        ///accountNameBank
        accountNameBank: json["bank"]["account_name"],

        ///bankNumber
        bankNumber: json["bank"]["number"],

        ///bankName
        bankName: json["bank"]["name"],
      );
}
