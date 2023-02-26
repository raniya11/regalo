import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regalo/admin/adminhomepage.dart';
import 'package:regalo/common/registerpage.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/screens/homepage.dart';
import 'package:regalo/screens/seller/sellerhomepage.dart';

import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showPass = true;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 30, top: 30),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  AppText(
                    text: "Hey! Welcome Back",
                    fw: FontWeight.bold,
                    size: 20,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty || value.length <= 4) {
                        return "Enter a valid username";
                      }
                    },
                    controller: usernameController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.pink, width: 3)),
                        hintText: "Username"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.length <= 5) {
                        return "Invalid Password";
                      }
                    },
                    controller: passwordController,
                    obscureText: showPass,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 3)),
                      hintText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () {
                          if (showPass == true) {
                            setState(() {
                              showPass = false;
                            });
                          } else {
                            setState(() {
                              showPass = true;
                            });
                          }
                        },
                        icon: showPass == true
                            ? Icon(
                                Icons.visibility,
                                color: priaryColor.withOpacity(0.6),
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: priaryColor,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                         if(usernameController.text.trim()=="admin@gmail.com" && passwordController.text.trim()=='12345678'){

                           Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminHomePage()));

                         }
                         else{

                           FirebaseAuth.instance
                               .signInWithEmailAndPassword(
                               email: usernameController.text.trim(),
                               password: passwordController.text)
                               .then((value) {
                             FirebaseFirestore.instance
                                 .collection('users')
                                 .doc(value.user!.uid)
                                 .get().then((value) {

                               if(value.data()!['usertype']=="user" ){

                                 print(value.data()!['usertype']);
                                 print(value.data()!['name']);


                                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>UserHomePage(


                                   name: value.data()!['name'],
                                   email:  value.data()!['email'],
                                   id:  value.data()!['uid'],
                                   status:  value.data()!['status'],
                                 )), (route) => false);

                               }

                               else if(value.data()!['usertype']=="seller"){

                                 //print(value.data()!['usertype'].toString());
                                 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>SellerHomePage(


                                   name: value.data()!['name'],
                                   email:  value.data()!['email'],
                                   address: value.data()!['address'],
                                   pincode: value.data()!['pincode'],
                                   phone: value.data()!['phone'],
                                   id:  value.data()!['uid'],
                                   status:  value.data()!['status'],
                                 )), (route) => false);



                               }
                             });




                           });
                         }
                        }
                      },
                      child: Container(
                        height: 45,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: AppText(
                            text: "Login",
                            size: 16,
                            color: Colors.white,
                            fw: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AppText(text: "Don't have an account"),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterPage()));
                          },
                          child: AppText(
                            text: "Register",
                            size: 16,
                            color: Colors.pink,
                            fw: FontWeight.w700,
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
