// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;
//
// import '../model/model_user.dart';
//
// class UserController extends ChangeNotifier{
//   List<UserModel>userList=[];
//   Future fetchData(context)async{
//     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
//     if(response.statusCode==200){
//       List responseData = jsonDecode(response.body);
//       userList = responseData.map((e) => UserModel.fromJson(e)).toList();
//       notifyListeners();
//     }
//     else{
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No Data Available")));
//     }
//   }
// }
//
