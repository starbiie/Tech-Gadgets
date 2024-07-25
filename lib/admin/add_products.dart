import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../utlis/image_pick_tile.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final GlobalKey<FormState> hospitalAddKey = GlobalKey<FormState>();
  final TextEditingController ProductNameController = TextEditingController();
  final TextEditingController ProductDetailsController = TextEditingController();
  final TextEditingController ProductLocationController = TextEditingController();
  final TextEditingController ProductPriceController = TextEditingController();

  Future<String> uploadImage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference reference = FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = reference.putFile(image);
      TaskSnapshot storageTaskSnapshot = await uploadTask;
      String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  XFile? _imageFile;
  String? imagePath;

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker _picker = ImagePicker();
    try {
      XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
          imagePath = pickedFile.path;
        });
      }
      print(_imageFile);
      print('/////////////$imagePath///////////////////');
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  final CollectionReference admins = FirebaseFirestore.instance.collection('admins');

  void addProducts(String imageUrl, String productType, String BrandType) {
    final ProductsDoc = admins.doc(FirebaseAuth.instance.currentUser!.uid);
    final data = {
      'ProductName': ProductNameController.text,
      'ProductDetails': ProductDetailsController.text,
      'ProductLocation': ProductLocationController.text,
      'Productprice': ProductPriceController.text,
      'ProductImage': imageUrl,
      'ProductType': productType,
      'BrandType': BrandType,
    };
    ProductsDoc.collection('Product').add(data);
  }

  String selectedProductType = 'All Products';
  String selectedBrandType = 'Branded';

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'AddProducts',
          style: TextStyle(
              color: Colors.black,
              fontFamily: GoogleFonts.abhayaLibre().fontFamily,
              fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: SingleChildScrollView(
          child: Form(
            key: hospitalAddKey,
            child: Column(
              children: [
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: ProductNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*this field is required';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: HexColor("F2DFB2"),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: HexColor("7A5600")),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    hintText: 'Products Name',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: HexColor("7A5600")),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  maxLines: 3,
                  textCapitalization: TextCapitalization.words,
                  controller: ProductDetailsController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*this field is required';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: HexColor("F2DFB2"),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: HexColor("7A5600")),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    hintText: 'Products Details',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: HexColor("7A5600")),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ImagePickTile(
                  onPressed: () {
                    _pickImage(context);
                  },
                  subtitile: _imageFile == null ? 'Nothing Selected' : imagePath!,
                  title: 'Product Photo',
                ),
                const SizedBox(
                  height: 20,
                ),
                DropdownButtonFormField<String>(
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
                          color: Colors.black,
                          fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    fillColor: HexColor("F2DFB2"),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: HexColor("7A5600")),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    hintText: 'Select Product Type',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: HexColor("7A5600")),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        controller: ProductPriceController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*this field is required';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          prefixText: "₹",
                          fillColor: HexColor("F2DFB2"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: HexColor("7A5600")),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                          hintText: 'Products Price',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: HexColor("7A5600")),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 5,
                      child: DropdownButtonFormField<String>(
                        value: selectedBrandType,
                        onChanged: (value) {
                          setState(() {
                            selectedBrandType = value!;
                          });
                        },
                        items: [
                          'Branded',
                          'UnBranded',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }).toList(),
                        decoration: InputDecoration(
                          fillColor: HexColor("F2DFB2"),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: HexColor("7A5600")),
                          ),
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                            fontWeight: FontWeight.w600,
                          ),
                          hintText: 'Brand Type',
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            borderSide: BorderSide(color: HexColor("7A5600")),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),


                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  textCapitalization: TextCapitalization.words,
                  controller: ProductLocationController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '*this field is required';
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    fillColor: HexColor("F2DFB2"),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: HexColor("7A5600")),
                    ),
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                      fontWeight: FontWeight.w600,
                    ),
                    hintText: 'Products Location',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      borderSide: BorderSide(color: HexColor("7A5600")),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (hospitalAddKey.currentState!.validate()) {
                      if (_imageFile != null) {
                        String imageUrl = await uploadImage(File(_imageFile!.path));
                        if (imageUrl.isNotEmpty) {
                          addProducts(imageUrl, selectedProductType, selectedBrandType);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Product Added Successfully')),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Image upload failed')),
                          );
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select an image')),
                        );
                      }

                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(MediaQuery.of(context).size.width, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Add Product',
                    style: TextStyle(
                      fontFamily: GoogleFonts.abhayaLibre().fontFamily,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
