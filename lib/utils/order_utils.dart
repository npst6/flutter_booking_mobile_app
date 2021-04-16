///Note file order_utils.dart

///Order utils
class OrderUtils {
  /// _singleton
  static final OrderUtils _singleton = OrderUtils._internal();
  OrderUtils._internal();
  factory OrderUtils() {
    return _singleton;
  }

  ///Start day order
  String startDay;

  ///End day order
  String endDay;

  ///Room number order
  int numberRoom;

  ///void set order
  void setOrder(
    String startDay1,
    String endDay1,
    int numberRoom1,
  ) {
    this.numberRoom = numberRoom1;
    this.endDay = endDay1;
    this.startDay = startDay1;
  }
}
