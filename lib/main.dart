import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:regalo/common/loginpage.dart';
import 'package:regalo/screens/seller/orderdetails.dart';
import 'package:regalo/screens/seller/sellerhomepage.dart';
import 'package:regalo/screens/seller/productdetails.dart';
import 'package:regalo/screens/storedetails.dart';
import 'package:regalo/screens/user/adapter.dart';
import 'package:regalo/screens/user/userregisteration.dart';
import 'common/splashpage.dart';

import 'package:regalo/screens/seller/orderdetails.dart';
import 'package:regalo/screens/seller/addproducts.dart';


void main()async{
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Hive.registerAdapter(ShoppingItemAdapter());
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashPage()
    );
  }
}
