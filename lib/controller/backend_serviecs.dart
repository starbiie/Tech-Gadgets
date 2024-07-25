import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:techgadgets/screens/home_Page.dart';

import '../model/model_user.dart';

class BackendServiecs {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  UserModel? _userModel;
  UserModel get usermodel => _userModel!;
  Future<void> saveUser(String username, String email) async {
    final userDoc = firebaseFirestore.collection("user").doc();
    _userModel =
        UserModel(userid: userDoc.id, username: username, email: email);
    await userDoc.set(_userModel!.tomap());
  }
  Future<void> signUp(
      String username, String email, String password, context) async {
    try {
      print('/////////////////////USER SIGNUP//////////////////////');
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final user = firebaseAuth.currentUser;
      user!.sendEmailVerification();
      await saveUser(username, email);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Its Successfull")));
    } catch (e) {
      print('////////////////////////SIGNUPERROR///////////////////////////');
          print(e);
    }
  }
  Future<void> LogIn(String email, String password, context) async {
    try {
      print('/////////////////////USER Login//////////////////////');
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final user = firebaseAuth.currentUser;
      final emailvarifide = user!.emailVerified;
      if (emailvarifide == false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Please varifie youremail")));
            } else {
            Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) => HomePage(),
            ));
            }
        } on FirebaseAuthException catch(e){ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));} catch (e) {
        print('////////////////////////LoginERROR///////////////////////////');
        print(e);
        }
        }
  Future<void> forgotPassword(String email, context) async {
    try {
      print('/////////////////////FORGOT PASSWORD//////////////////////');
      await firebaseAuth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password reset email sent. Check yourinbox.")),
          );
          } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? "Error")));
      } catch (e) {
        print('////////////////////////FORGOT PASSWORDERROR///////////////////////////');
            print(e);}

  }}