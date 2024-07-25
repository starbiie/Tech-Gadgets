import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../model/model_user.dart';
import '../utlis/NewBox.dart';
import '../utlis/headers.dart';
import 'productDetailPage.dart'; // Adjust the import path accordingly

class HomePage extends StatefulWidget {
  final UserModel? user;
  const HomePage({super.key, this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedProductType = 'All Products';

  @override
  Widget build(BuildContext context) {
    var numOfItems = 3;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi ${widget.user?.username ?? 'Guest'}"),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.bell, color: Colors.black),
                ),
              ),
              if (numOfItems != 0)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2.5),
                    decoration: BoxDecoration(
                      color: HexColor("F2DFB2"),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.red, width: 2),
                    ),
                    child: Text(
                      "$numOfItems",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          children: [
            SizedBox(
              width: 55,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: HomeHeader(),
            ),
            SizedBox(
              width: 75,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sort by :",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: HexColor("#404040")),
                  ),
                  SizedBox(
                    height: 35,
                    width: 155,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButtonFormField<String>(
                        isDense: true,
                        value: selectedProductType,
                        onChanged: (value) {
                          setState(() {
                            selectedProductType = value!;
                          });
                        },
                        items: [
                          'All Products',
                          'furniture',
                          'electronics',
                          'fashion&dress',
                          'books'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 13,
                                color: HexColor("#404040"),
                                fontFamily: 'AbhayaLibre_regular',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 19, vertical: 3),
                          fillColor: HexColor("F2DFB2"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                            borderSide: BorderSide(color: HexColor("7A5600")),
                          ),
                          hintStyle: TextStyle(
                            color: HexColor("7A5600"),
                            fontFamily: 'AbhayaLibre_regular',
                            fontWeight: FontWeight.w600,
                          ),
                          hintText: 'Select Products',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(25),
                            ),
                            borderSide: BorderSide(color: HexColor("7A5600")),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: selectedProductType == 'All Products'
                    ? FirebaseFirestore.instance
                    .collection('admins')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Product')
                    .snapshots()
                    : FirebaseFirestore.instance
                    .collection('admins')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('Product')
                    .where('ProductType', isEqualTo: selectedProductType)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: LoadingAnimationWidget.flickr(
                        rightDotColor: Colors.black,
                        leftDotColor: const Color(0xfffd0079),
                        size: 30,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    if (snapshot.error.toString().contains('FAILED_PRECONDITION')) {
                      return Center(
                        child: Text(
                          'Firestore requires a composite index for this query. Please create it in your Firebase console.',
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return Text('Error: ${snapshot.error}');
                    }
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text('No products found'),
                    );
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        var product = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                    img: product['ProductImage'],
                                  ),
                                ),
                              );
                            },
                            child: NeuBox(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: NetworkImage(product['ProductImage']),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: Colors.black26,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        height: 40,
                                        width: MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            product['ProductName'],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
