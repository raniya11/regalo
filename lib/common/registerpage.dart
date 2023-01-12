import 'package:flutter/material.dart';
import 'package:regalo/constants/colors.dart';
import 'package:regalo/screens/sellerregister.dart';
import 'package:regalo/screens/user/userregisteration.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: priaryColor,
          bottom: const TabBar(
            indicatorColor: Colors.white,

            tabs: [
              Tab(icon: Text("User")),
              Tab(icon: Text("Seller")),
            ],
          ),
        ),
        body: const TabBarView(
          children: [UserRegisteration(), SellerRegisteration()],
        ),
      ),
    );
  }
}
