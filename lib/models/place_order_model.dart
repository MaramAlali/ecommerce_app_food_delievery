import 'cart_model.dart';

class PlaceOrderBody {
  List<CartModel>? _cart;
  late double _orderAmount;
  late String _orderNote;
  late double _distance;
  late  String _contactPersonName;
  late String _contactPersonNumber;
  late String _orderType;
  late String _paymentMethod;

  PlaceOrderBody(
      {required List<CartModel> cart,
        required double orderAmount,
        required double distance,
        required String scheduleAt,
        required String orderNote,
        required String address,
        required String latitude,
        required String longitude,
        required String contactPersonName,
        required String contactPersonNumber,
        required String orderType,
        required String paymentMethod,


      }){
    this._cart = cart;
    this._orderAmount = orderAmount;
    this._orderNote = orderNote;
    this._distance = distance;
    this._contactPersonName = contactPersonName;
    this._contactPersonNumber = contactPersonNumber;
    this._orderType=orderType;
    this._paymentMethod=paymentMethod;
  }

  List<CartModel> get cart => _cart!;

  double get orderAmount => _orderAmount;

  String get orderNote => _orderNote;

  double get distance => _distance;

  String get contactPersonName => _contactPersonName;
  String get contactPersonNumber => _contactPersonNumber;
  String get orderType => _orderType;
  String get paymentMethod => _paymentMethod;


  PlaceOrderBody.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      _cart = [];
      json['cart'].forEach((v) {
        _cart!.add(new CartModel.fromJson(v));
      });
    }

    _orderAmount = json['order_amount'];

    _orderNote = json['order_note'];

    _distance = json['distance'];
    _contactPersonName = json['contact_person_name'];
    _contactPersonNumber = json['contact_person_number'];
    _orderType=json['order_type'];
    _paymentMethod=json['payment_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this._cart != null) {
      data['cart'] = this._cart!.map((v) => v.toJson()).toList();
    }
    data['order_amount'] = _orderAmount;
    data['order_note'] = _orderNote;
    data['distance'] = _distance;
    data['contact_person_name'] = _contactPersonName;
    data['contact_person_number'] = _contactPersonNumber;
    data['order_type'] = _orderType;
    data['payment_method'] = _paymentMethod;

    return data;
  }

}

