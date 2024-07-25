import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:techgadgets/admin/products/allProducts.dart';
import 'package:techgadgets/admin/products/books.dart';
import 'package:techgadgets/admin/products/electro.dart';
import 'package:techgadgets/admin/products/fashion.dart';
import 'package:techgadgets/admin/products/furnitures.dart';

import '../utlis/shimmer_effect.dart';
import 'add_products.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final CollectionReference admins = FirebaseFirestore.instance
      .collection('admins')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Product');

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Products",
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AddProducts(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.add_to_photos_outlined,
                  color: Colors.black,
                ),
              )
            ],
            bottom: TabBar(tabs: [
              Tab(
                text: "All Products",
              ),
              Tab(
                text: "furniture",
              ),
              Tab(
                text: "electronics",
              ),
              Tab(
                text: "fashion&dress",
              ),
              Tab(
                text: "books",
              ),
            ]),
          ),
          body: TabBarView(children: [
            AllProduct(),
            Furniture(),
            Electro(),
            Fashion(),
            Books(),
          ]),
        ));
  }
}
