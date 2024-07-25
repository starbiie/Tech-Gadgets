import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:techgadgets/admin/login.dart';
import 'package:techgadgets/screens/Registration.dart';



class ContinueAs extends StatelessWidget {
  const ContinueAs({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: HexColor("#CECBC3"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You're ?",
              style: TextStyle(
                  fontFamily: 'AbhayaLibre', color: Colors.black, fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: width / 2,
              child: ElevatedButton(
                style:  ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>  SignUp(),
                    ),
                  );
                },
                child: const Text(
                  'User',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'AbhayaLibre',
                      fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // SizedBox(
            //   width: width / 2,
            //   child: ElevatedButton(
            //     style:  ButtonStyle(
            //         backgroundColor: MaterialStatePropertyAll(HexColor("7A5600"))),
            //     onPressed: () {
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (context) =>  const SitterSignup(),
            //         ),
            //       );
            //     },
            //     child: const Text(
            //       'Sitter',
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontFamily: 'AbhayaLibre',
            //           fontSize: 20),
            //     ),
            //   ),
            // ),

            SizedBox(
              width: width / 2,
              child: ElevatedButton(
                style:  ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black)),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>  AdminLoginPage(),
                    ),
                  );
                },
                child: const Text(
                  'Admin',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'AbhayaLibre',
                      fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
