class FrequentlyAskedQuestionsModel {
  bool? status;
  String? message;
  Data? data;


  FrequentlyAskedQuestionsModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  List<DataItem>? data;

  Data.fromJson(Map<String, dynamic> json)
  {
    if (json['data'] != null) {
      data = <DataItem>[];
      json['data'].forEach((v) {
        data!.add(DataItem.fromJson(v));
      });
    }
  }

}

class DataItem {
  int? id;
  String? question;
  String? answer;

  DataItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
    answer = json['answer'];
  }

}
