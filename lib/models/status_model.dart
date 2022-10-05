import 'package:cloud_firestore/cloud_firestore.dart';

class StatusModel {
  String? person;
  String? personId;
  bool? status;
  String? startTime;

  StatusModel({this.person, this.personId, this.status, this.startTime});

  StatusModel.fromJson(Map<String, dynamic> json) {
    person = json['person'];
    personId = json['personId'];
    status = json['status'];
    startTime = json['startTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['person'] = this.person;
    data['personId'] = this.personId;
    data['status'] = this.status;
    data['startTime'] = this.startTime;
    return data;
  }
}