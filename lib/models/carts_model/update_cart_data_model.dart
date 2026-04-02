class UpdateCartModel {
  bool? status;
  String? message;
  Data? data;


  UpdateCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  Cart? cart;
  dynamic subTotal;
  dynamic total;


  Data.fromJson(Map<String, dynamic> json) {
    cart = json['cart'] != null ?  Cart.fromJson(json['cart']) : null;
    subTotal = json['sub_total'];
    total = json['total'];
  }

}

class Cart {
  int ? id;
  dynamic quantity;
  Product? product;


  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ?  Product.fromJson(json['product']) : null;
  }

}

class Product {
  int ? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
  }

}
