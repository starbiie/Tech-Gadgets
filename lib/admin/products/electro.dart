
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utlis/shimmer_effect.dart';

Widget Electro() {
final CollectionReference admins = FirebaseFirestore.instance
    .collection('admins')
    .doc(FirebaseAuth.instance.currentUser!.uid)
    .collection('Product');

return StreamBuilder(
stream: admins.where('ProductType', isEqualTo: 'electronics')
    .snapshots(),
builder: (context, snapshot) {
if (snapshot.connectionState == ConnectionState.waiting) {
return ShimmerList();
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
} else {
return ListView.builder(
itemCount: snapshot.data!.docs.length,
itemBuilder: (context, index) {
var doc = snapshot.data!.docs[index];
return Padding(
padding: const EdgeInsets.all(8.0),
child: Card(
child: Container(
height: 100,
width: MediaQuery
    .of(context)
    .size
    .width,
decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(15),
),
child: Padding(
padding: const EdgeInsets.all(10.0),
child: Center(
child: Row(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
doc['ProductImage'] != null
? Image.network(
doc['ProductImage'],
height: 80,
width: 80,
errorBuilder: (context, error, stackTrace) {
return Placeholder(
fallbackHeight: 80,
fallbackWidth: 80,
color: Colors.grey,
child: Image.asset(
"asset/istockphoto-610003972-612x612.jpg"),
);
},
)
    : const Placeholder(
fallbackHeight: 80,
fallbackWidth: 80,
),
const SizedBox(width: 15),
Expanded(
child: Column(
mainAxisAlignment: MainAxisAlignment.start,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
const SizedBox(height: 10),
Text(
doc['ProductName'] ?? 'No Name',
style: const TextStyle(
fontWeight: FontWeight.w700),
),
Text(
doc['ProductDetails'] ?? 'No Details',
style: const TextStyle(
overflow: TextOverflow.ellipsis,
fontSize: 10),
maxLines: 2,
),
Text(
doc['ProductLocation'] ??
'No ProductLocation',
style: const TextStyle(fontSize: 10),
),
],
),
),
Padding(
padding: const EdgeInsets.only(top: 30.0),
child: InkWell(
onTap: () {},
child: Container(
width: 65,
height: 20,
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(5),
color: const Color(0xff019744),
),
child: const Center(
child: Text(
"Edit Product",
style: TextStyle(
fontSize: 10, color: Colors.white),
),
),
),
),
),
const SizedBox(width: 10),
],
),
),
),
),
),
);
},
);
}
},
);
}
