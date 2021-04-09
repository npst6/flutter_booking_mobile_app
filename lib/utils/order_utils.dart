///Note file order_utils.dart

///
class OrderUtils {
  static final OrderUtils _singleton = OrderUtils._internal(); ///
  OrderUtils._internal(); ///

  factory OrderUtils() {
    return _singleton;
  }

  String startDay; ///Start day order
  String endDay; ///End day order
  int numberRoom; ///Room number order

  ///
  void setOrder(String startDay1, String endDay1, int numberRoom1) {
    this.numberRoom = numberRoom1;
    this.endDay = endDay1;
    this.startDay = startDay1;
  }
}
