///Note item_model.dart

///ItemModel intermediate in dropdown text field
class ItemModel {
  ///Id
  String id;

  ///name
  String name;

  ItemModel({
    this.id,
    this.name,
  });

  factory ItemModel.formJson(Map<String, dynamic> json) => ItemModel(
        ///name
        name: json["name"],

        ///id
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}
