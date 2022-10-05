import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shop_firebase/models/hisstory_model.dart';

class HistoryController extends GetxController{
  final CollectionReference _hisstoryCollection = FirebaseFirestore.instance.collection("history");
  final FirebaseAuth _auth = FirebaseAuth.instance;

  HistoryModel? _history;

  bool _isLoader = false;
  bool get isLoader =>_isLoader;

  HistoryModel? _getHistory;
  HistoryModel? get history =>_getHistory;

  List<HistoryModel> _historyList =[];
  List<HistoryModel> get historyList =>_historyList;

  // add startTime
  addStartTime(String userId, String name, String start, String date){
    _history = HistoryModel(
      userId: userId,
      name: name,
      startTime: start,
      date: date
    );
  }

  // add data from database
  Future<void> addHistory(String end){
      return _hisstoryCollection.add({
        "userId" : _history!.userId,
        "name": _history!.name,
        "start": _history!.startTime,
        "end": end,
        "date": _history!.date
      }).then((value) => null)
          .catchError((e){
            print("Add data from database error: "+e.toString());
      });
  }

  // get History
  Future<void> getHistory() async{
    _historyList=[];
    await _hisstoryCollection.orderBy("start", descending: true).limit(100).get()
    .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((element) {
        _historyList.add(
          HistoryModel(
            userId: element["userId"],
            name: element["name"],
            startTime: element["start"],
            endTime: element["end"],
            date: element["date"],
          )
        );
        _isLoader = true;
        update();
      });
    })
    .catchError((e){
      print("Get history error: "+e.toString());
    });
  }

  // search
  Future<void> search(String date) async{
    await _hisstoryCollection.where('date', isEqualTo: date).get()
        .then((QuerySnapshot snapshot){
          if(snapshot.docs.isNotEmpty){
            _historyList=[];
            snapshot.docs.forEach((element) {
              _historyList.add(
                  HistoryModel(
                    userId: element["userId"],
                    name: element["name"],
                    startTime: element["start"],
                    endTime: element["end"],
                    date: element["date"],
                  ));
              _isLoader = true;
              update();
            });
          }else{
            _isLoader = false;
            update();
          }
    });

  }

/* Dữ liệu kiểu map

  // add startTime
  addHistory(String startTime){
          _history = HistoryModel(startTime: startTime);
  }

  // add data from database
  Future<void> setHistory(String useId, String endTime, String name){
    return _hisstoryCollection.doc(useId)
    .set({
      endTime: { "startTime": _history!.startTime,
        "endTime": endTime,
        "name": name}
    },
      SetOptions(merge: true),
    ).then((value) => null)
    .catchError((onError){
      print("error history: "+ onError.toString());
    });
    ;
  }

  // get data to database
  Future<void> getHistory() async {
    _historyList=[];
    await _hisstoryCollection.doc(_auth.currentUser!.uid)
        .get()
        .then((DocumentSnapshot snapshot){
          if(snapshot.exists){
            var data = snapshot.data() as Map<String, dynamic>;
            data.entries.map((e) {
              _historyList.add(
                  HistoryModel(
                      userId: e.key,
                      startTime: e.value["startTime"],
                      endTime: e.value["endTime"],
                      name: e.value["name"]
                  ));
            }).toList();
            _isLoader = true;
            update();
          }

    })
        .catchError((onError){
          print("get history error: "+onError.toString());
    });
  }

  // get all history
  Future<void> getAllHistory() async {
    _historyList=[];
    await _hisstoryCollection
        .get()
        .then((QuerySnapshot snapshot){
        var data = snapshot.docs;
        var map ={};
        var map2 ={};
        data.forEach((element) {
          map[element.id] = element.data();
          });
        map.forEach((key, value) {
          map2.addAll(value);
        });
        map2.entries.map((e) {
          _historyList.add(HistoryModel(
              userId: e.key,
              startTime: e.value["startTime"],
              endTime: e.value["endTime"],
              name: e.value["name"]
          ));
        }
        ).toList();
        _isLoader = true;
        update();
    })
        .catchError((onError){
      print("get history error: "+onError.toString());
    });
  }
  
  Future<void> search() async
  {
    print("test");
    await _hisstoryCollection.where("2022",arrayContains: "cuong").get()
        .then((QuerySnapshot snapshot){
          snapshot.docs.forEach((element) {
            print("test2");
            print("search: "+element.data().toString());
          });
    }).catchError((e){
      print("error: "+e.toString());
    });
    print("test 3");
    update();
  }

*/

}

