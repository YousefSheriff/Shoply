class FavoritesModel
{
  bool? status;
  Data? data;


  FavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data
{
  int? currentPage;
  List<FavoritesDataModel>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;



  Data.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'];
    // json['data'].forEach((element)
    // {
    //   data!.add(FavoritesDataModel.fromJson(element));
    // });
    if (json['data'] != null)
    {
      data = [];
      json['data'].forEach((v) {
        data!.add(new FavoritesDataModel.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

}

class FavoritesDataModel {
  int? id;
  FavProduct? product;


  FavoritesDataModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    product = json['product'] != null ? FavProduct.fromJson(json['product']) : null;
  }

}

class FavProduct
{
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;


  FavProduct.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
