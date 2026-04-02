class AddressesModel {
  bool? status;
  String? message;
  Data? data;


  AddressesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<AddressesData>? data;



  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <AddressesData>[];
      json['data'].forEach((v) {
        data!.add(AddressesData.fromJson(v));
      });
    }
  }

}

class AddressesData {
  int? id;
  String? name;
  String? city;
  String? region;
  String? details;
  String? notes;
  dynamic latitude;
  dynamic longitude;


  AddressesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    region = json['region'];
    details = json['details'];
    notes = json['notes'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

}
