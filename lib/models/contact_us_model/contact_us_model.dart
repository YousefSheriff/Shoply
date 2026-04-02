class ContactUsModel {
  bool? status;
  String? message;
  Data? data;


  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }


}

class Data {
  List<ContactDataItem>? data;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ContactDataItem>[];
      json['data'].forEach((v) {
        data!.add( ContactDataItem.fromJson(v));
      });
    }
  }

}

class ContactDataItem {
  int? id;
  int? type;
  String? value;
  String? image;


  ContactDataItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    value = json['value'];
    image = json['image'];
  }

}
