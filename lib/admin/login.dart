import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:animate_do/animate_do.dart';
import 'package:techgadgets/admin/ctrl/admin_ctrl.dart';
import 'package:techgadgets/admin/view_purchased_product.dart';
import '../controller/backend_serviecs.dart';
import '../screens/home_Page.dart';

class AdminLoginPage extends StatefulWidget {
  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var visible = false;
  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  AdminController adminController = AdminController(FirebaseAuth.instance);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor("#CECBC3"),
        // backgroundColor: HexColor("#F9B675"),
        body: SingleChildScrollView(
          child: Container(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/background.png'),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 30,
                          width: 80,
                          height: 200,
                          child: FadeInUp(
                              duration: Duration(seconds: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-1.png'))),
                              )),
                        ),
                        Positioned(
                          left: 140,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1200),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/light-2.png'))),
                              )),
                        ),
                        Positioned(
                          right: 40,
                          top: 40,
                          width: 80,
                          height: 150,
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1300),
                              child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/clock.png'))),
                              )),
                        ),
                        Positioned(
                          child: FadeInUp(
                              duration: Duration(milliseconds: 1600),
                              child: Container(
                                margin: EdgeInsets.only(top: 50),
                                child: Center(
                                  child: Text(
                                    "Admin Login!!!",
                                    style: TextStyle(
                                        fontFamily: GoogleFonts.lora().fontFamily,

                                        color: Colors.black87,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                            duration: Duration(milliseconds: 1800),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Color.fromRGBO(143, 148, 251, 1)),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                         Colors.grey.shade900,
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color.fromRGBO(
                                                    143, 148, 251, 1)))),
                                    child: TextField(

                                      controller: _emailController,
                                      decoration: InputDecoration(

                                          border: InputBorder.none,
                                          hintText: "Email",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[700])),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[700])),
                                    ),
                                  )
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        FadeInUp(
                            duration: Duration(milliseconds: 1900),
                            child: InkWell(
                              onTap: () {
                                adminController.adminLogin(
                                    _emailController.text,
                                    _passwordController.text,
                                    context);




                              },

                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(colors: [
Colors.black,                                     Colors.black87,
                                    ])),
                                child: Center(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.grey[700],                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                        // SizedBox(
                        //   height: 70,
                        // ),
                        // FadeInUp(
                        //     duration: Duration(milliseconds: 2000),
                        //     child: Text(
                        //       "Forgot Password?",
                        //       style: TextStyle(
                        //           color: Colors.grey[700]),
                        //     )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
