import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_firebase/controller/auth_controller.dart';
import 'package:shop_firebase/models/myuser_model.dart';

class MyUserController extends GetxController{

  final CollectionReference _myUserCollectionReference = FirebaseFirestore.instance.collection("myuser");

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  MyUserModel? _myUser;
  MyUserModel? get myUser=>_myUser;

  Future<void> getMyUser() async {
    await _myUserCollectionReference.doc(_firebaseAuth.currentUser!.uid).get()
        .then((DocumentSnapshot snapshot) {
          if(snapshot.exists){
           var myUser = snapshot.data() as Map<String, dynamic>;
            _myUser = MyUserModel.fromJson(myUser);
           // var userObj = MyUserModel.fromJson(myUser);
           //  _listMyuser.add(
           //      MyUserModel(id: userObj.id,name: userObj.name, phone: userObj.phone, email: userObj.email)
           //  );
            update();
          }
    });

  }

}