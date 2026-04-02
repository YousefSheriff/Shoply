class CategoryDetailsModel {
  bool? status;
  Null? message;
  DataList? data;


  CategoryDetailsModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  DataList.fromJson(json['data']) : null;
  }

}

class DataList {
  int? currentPage;
  List<DataItem>? data=[];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;


  DataList.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'];
    if (json['data'] != null)
    {
      json['data'].forEach((v)
      {
        data!.add(DataItem.fromJson(v));
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

class   DataItem
{
  int? id;
  String? name;
  String? image;


  DataItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}
