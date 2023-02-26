import 'package:flutter/material.dart';
class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: [
            Container(
              width: 50,
              child: Image.asset(
                'assets/images/logonew.png',
                scale: 6,
              ),
            ),
            Container(
              child: RichText(
                text: TextSpan(
                  text: 'REG',
                  style: TextStyle(color: Colors.deepOrangeAccent,fontSize: 26,fontWeight: FontWeight.bold),
                  children: const <TextSpan>[
                    TextSpan(text: 'ALO', style: TextStyle(color: Colors.pinkAccent,fontSize: 26)),
                  ],
                ),
              ),
            )
          ],


        )
    );
  }
}
