import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:regalo/common/loginpage.dart';
import 'package:regalo/screens/homepage.dart';
import 'package:regalo/utilities/apptext.dart';
import 'package:regalo/utilities/headerwidget.dart';
import 'package:regalo/screens/seller/sellerhomepage.dart';
import 'package:regalo/constants/colors.dart';
class SellerRegisteration extends StatefulWidget {
  const SellerRegisteration({Key? key}) : super(key: key);

  @override
  State<SellerRegisteration> createState() => _SellerRegisterationState();
}

class _SellerRegisterationState extends State<SellerRegisteration> {
  bool showPass = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController phnController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
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

              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return "Enter a valid Email";
                  }
                },
                controller: emailController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.pink, width: 3)),
                    hintText: "Email"),
              ),
              SizedBox(
                height: 10,
              ),

              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a valid id";
                  }
                },
                controller: idController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.pink, width: 3)),
                    hintText: "Business ID"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a valid name";
                  }
                },
                controller: usernameController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.pink, width: 3)),
                    hintText: "Full Name"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a valid address";
                  }
                },
                controller: addressController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.pink, width: 3)),
                    hintText: "Address"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter a valid pincode";
                  }
                },
                controller: pincodeController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.pink, width: 3)),
                    hintText: "Pin Code"),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.length <= 5) {
                    return "Password should be more than 5";
                  }
                },
                controller: passwordController,
                obscureText: showPass,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(color: Colors.pink, width: 3)),
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
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty || value.length<=9) {
                    return "Enter a valid number";
                  }
                },
                controller: phnController,
                decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(color: Colors.pink, width: 3)),
                    hintText: "Mobile Number"),
              ),
              SizedBox(
                height: 30,
              ),



              Center(
                child: InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {


                        FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim()).then((value) {



                          FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({

                            "uid":value.user!.uid,
                            "name":usernameController.text,
                            'email':emailController.text.trim(),
                            'passsword':passwordController.text,
                            'id':idController.text,
                            'address':addressController.text,
                            'pincode':pincodeController.text,
                            'phone':phnController.text,
                            'usertype':"seller",
                            "createdat":DateTime.now(),
                            'status':0

                          }).then((value){
                            ScaffoldMessenger.of(context).showSnackBar(

                                SnackBar(
                                    backgroundColor: priaryColor,
                                    content: Text("Registration Success")));

                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);

                          });
                        });




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
                        text: "Register",
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
                  AppText(text: "Already a member"),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));


                    },
                    child:
                    AppText(
                      text: "Login",
                      size: 16,
                      fw: FontWeight.w700,
                      color: Colors.pink,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),

    );
  }
}
