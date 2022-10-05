import 'dart:async';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shop_firebase/controller/myuser_controller.dart';
import 'package:shop_firebase/models/myuser_model.dart';

class AuthController extends GetxController{

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _myUserCollectionReference = FirebaseFirestore.instance.collection("myuser");

  MyUserController _myUserController = MyUserController();

  // Sign up
  Future signUp(String name, String email, String password,Function onSuccess, Function(String) onError) async{
    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        value.user!.updateDisplayName(name);
        onSuccess();
        // var myUser = {
        //   'id': value.user!.uid,
        //   'name': name,
        //   'email': email,
        //   'phone': phone
        // };
        // return _myUserCollectionReference.doc(value.user!.uid).set(myUser)
        //     .then((value) async {
        //   onSuccess();
        // });
      });
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        onError(('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        onError('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }


  Future getData(String userId) async{
   var myUser = await _myUserCollectionReference.doc(userId).get();
  }

  // sign In
  Future<void> signIn (String email, String password, Function onSuccess , Function(String) onError) async {
    try{
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value){
            onSuccess();
            return value;
      });
    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        print('No user found for that email');
        onError("No user found for that email");
      }else if(e.code == 'wrong-password'){
        print('Wrong password provided for that user');
        onError("Wrong password provided for that user");
      }
    }
  }

  // signOut
  Future<void> signOut(Function navi) async {
    await _firebaseAuth.signOut();
    navi();
  }

  // check Email verify
  Future<void> checkEmailVerified(Timer timer, Function verify) async {
    User? user = _firebaseAuth.currentUser;
    await user!.reload();
    if(user.emailVerified){
      verify();
      timer.cancel();
    }
  }

  // reset password
  Future<void> resetPassword(String email, Function access, Function(String) onError) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email).then((_) {
        access();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email');
        onError("No user found for that email");
      }
    }
  }

  // Change password
 Future<void> changePassword(String oldPass, String newPassword, Function(String) onError, Function access) async {
   User? user = _firebaseAuth.currentUser;
   var credential = EmailAuthProvider.credential(
       email: user!.email!, password: oldPass);
   try {
     await user.reauthenticateWithCredential(credential).then((_) {
       user.updatePassword(newPassword).then((_){
         access();
       });
     });
   } on FirebaseAuthException catch (e) {
     if (e.code == 'wrong-password') {
       print('Wrong password provided for that user');
       onError("Wrong password provided for that user");
     }
   }
 }

 // sign up with Google
  Future<void> signInWithGoogle(Function access) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential).then((_){
      return access();
    });
  }

}