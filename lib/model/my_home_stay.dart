///Note file my_home_stay.dart

///Describe MyHomeStay (Name, phone, create day, image, name account bank, number account bank, name bank of shop)
class MyHomeStay {String name; String phone; List<int> listReviews;
                  String createDay; int status; String urlImage;
                  String accountNameBank; String bankNumber; String bankName;

  MyHomeStay({this.name, this.phone, this.listReviews,
              this.createDay, this.status, this.urlImage,
              this.accountNameBank, this.bankNumber, this.bankName,
  });

  ///
  factory MyHomeStay.formJson(Map<String, dynamic> json) => MyHomeStay(
    name: json['name'],
    phone: json['phone'],
    listReviews: json['list_review'] ?? [].cast<int>(),
    createDay: json["create_day"],
    status: json["status"] ?? 1,
    urlImage: json["url_image"],
    accountNameBank: json["bank"]["account_name"],
    bankNumber: json["bank"]["number"],
    bankName: json["bank"]["name"],
  );
}
