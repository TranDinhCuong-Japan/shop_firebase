import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_firebase/models/status_model.dart';
import 'package:firebase_database/firebase_database.dart';

class StatusController extends GetxController{
  final CollectionReference _statusConllection = FirebaseFirestore.instance.collection("status");
  final DatabaseReference _reference = FirebaseDatabase.instance.ref().child("status");

  // final FirebaseDatabase _database = FirebaseDatabase.instance;

  StatusModel? _status;
  StatusModel? get status =>_status;

  bool _isLoaded = false;
  bool get isLoaded =>_isLoaded;

  // creat realtime database
  Future<void> setData() async{
    await _reference.set({
      'status': false,
      'personId': "userId",
      'person': "userName",
      'startTime': "DateTime.now()"
    }).then((value) {}).catchError((onError){
      print("Realtime error: "+ onError.toString());
    });
  }

  //Update realtime
  Future<void> updateStatusReal(bool status, String name, String id, String date) async{
    var updateStatus = {'status': status,
      'personId': id,
      'person': name,
      'startTime': date};
    await FirebaseDatabase.instance
        .ref('status')
        .update(updateStatus)
        .then((value) {})
        .catchError((error) {
      print(error.toString());
    });
  }

  // get status
  Future<void> getStatusReal() async{
    _reference.onValue.listen((DatabaseEvent event) {
     var data = event.snapshot.value;
     _status = StatusModel.fromJson(jsonDecode(jsonEncode(data)));
      _isLoaded = true;
      update();
    });
  }



  // get status
  Future<void> getStatus() async {
   await _statusConllection.doc("status").get().then((DocumentSnapshot snapshot) {
      if(snapshot.exists){
        var status = snapshot.data() as Map<String, dynamic>;
        _status = StatusModel.fromJson(status);
        _isLoaded = true;
        update();
      }
    });
  }

  //update
  Future<void> updateStatus(bool status, String userId, String userName, DateTime dateTime){
    return _statusConllection.doc("status")
        .update({
          'status': status,
          'personId': userId,
          'person': userName,
          'startTime': dateTime
        })
        .then((value) => getStatus())
        .catchError((error) => print("Failed to update user: $error"));
}
}