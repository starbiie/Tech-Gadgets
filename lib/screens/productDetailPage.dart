import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../utlis/buildBulletListItem.dart';
import '../utlis/buildDetailItem.dart';
import '../utlis/buildFeatureRatingBar.dart';
// import '../servieces/productServices.dart';

class ProductDetailPage extends StatefulWidget {
  ProductDetailPage({
    super.key,  required this.img,
    // required this.img,
    // required this.text,
    // required this.pri,
  });

  final String img;
  // final String text;
  // final String pri;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  var pass = true;

  @override
  void initState() {
    super.initState();


    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: HexColor("F2DFB2"),
      appBar: AppBar(
        // backgroundColor: HexColor("F2DFB2"),
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(
                      title: Text("Add to favourite"),
                      actions: [
                        Text("yes"),
                        Text("Cancel"),
                      ],
                    );
                  },
                );
              },
              child: IconButton(
                onPressed: () {
                  setState(() {
                    pass = !pass;
                  });
                },
                icon: pass
                    ? const Icon(Icons.favorite_outline_outlined)



                    : const Icon(Icons.favorite, color: Colors.red),
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.img),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'widget.text',
                      style: TextStyle(
                          color: HexColor("604401"),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Gluten-free, cruelty-free & preservative-free",
                      style: TextStyle(
                          color: HexColor("3A3A3A"),
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "MRP:",
                          style: TextStyle(
                              color: HexColor("636161"),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "₹750.00:",
                          style: TextStyle(
                            color: HexColor("636161"),
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                        Text(
                          'widget.pri',
                          style: TextStyle(
                              color: HexColor("000000"),
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '15% Off',
                          style: TextStyle(
                              color: HexColor("E19B47"),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Product details",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HexColor("604401")),
                    ),
                    const SizedBox(height: 15),
                    buildDetailItem("Diet Type", "veg Similarly"),
                    buildDetailItem("Age Range (Description)", "veg Similarly"),
                    buildDetailItem("Item Form", "veg Similarly"),
                    buildDetailItem(
                        "Specific Uses For Product", "veg Similarly"),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      "About this item",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HexColor("604401")),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBulletListItem(
                        "Complete and balanced nutrition for "),
                    buildBulletListItem(
                        "Antioxidants, vitamins and other "),
                    buildBulletListItem(
                        "Enriched with omega 3 and 6 fatty acids for "),
                    buildBulletListItem("Ideal for all breeds"),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Customer ratings by feature",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: HexColor("604401")),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 45,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.all(Colors.white54),
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    onPressed: () async {

                    },
                    child: const Text(
                      'ADD TO CART',
                      style: TextStyle(
                        fontFamily: 'AbhayaLibre_regular',
                        color: Colors.white,
                        fontSize: 20,
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
  }
}
