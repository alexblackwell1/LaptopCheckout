
import 'package:checkoutui/check_in/HookInPage.dart';
import 'package:checkoutui/check_in/ThankPage.dart';
import 'package:flutter/material.dart';

class SwipeInPage extends StatefulWidget {
  const SwipeInPage({Key? key}) : super(key: key);

  @override
  State<SwipeInPage> createState() => _SwipeInPageState();
}

class _SwipeInPageState extends State<SwipeInPage> {
  int userID = 0;

  @override
  Widget build(BuildContext context) {

    if (userID > 100000000 && userID < 1000000000) {
      // sendStudent(userID.toString());
      return const HookInPage();
    }

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    
    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("images/terms_bkg.jpg")
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Swipe to check in",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24
              ),
            ),
            SizedBox(
              width: 0.0001,
              height: 0.0001,
              child:TextField(
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    userID = int.tryParse(value)!;
                  });
                },
              )
            )
          ],
        )
      )
    );
  }
}