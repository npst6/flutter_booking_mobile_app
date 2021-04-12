///Note item_model.dart

///ItemModel model trung gian trong dropdown text field
class ItemModel {
  String id; ///
  String name; ///

  ///
  ItemModel({
    this.id,
    this.name,
  });

  ///
  factory ItemModel.formJson(Map<String, dynamic> json) => ItemModel(
    name: json["name"],
    id: json["id"],
  );

  ///
  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
