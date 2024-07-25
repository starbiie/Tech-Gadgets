import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:techgadgets/screens/countinue_as.dart';
import 'package:techgadgets/screens/test.dart';

import 'firebase_options.dart';

void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),debugShowCheckedModeBanner: false,
      home:ContinueAs(),
    );
  }
}
