import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStoreAuthData{
  storeSignUpData(String name){
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
      'name':name
    }).whenComplete((){
      print("Auth data is stored");
    });
  }
}