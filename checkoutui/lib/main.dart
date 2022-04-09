import 'package:flutter/material.dart';
import 'CheckoutPage.dart';

void main() {
  runApp(const CheckoutUI());
}

class CheckoutUI extends StatelessWidget {
  const CheckoutUI({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Laptop Checkout',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.transparent,
        primaryColor: Colors.black,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int userID = 0;

  Widget build(BuildContext context) {

    if (userID > 100000000 && userID < 1000000000)
      return CheckoutPage();

    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    int numComputers = 0;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        decoration: const BoxDecoration(
          color: Colors.black,
          // image: DecorationImage(
          //   image: AssetImage("assets/images/lib_bkg.jpg")
          // )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                numComputers.toString() + " Laptops Remaining",
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            ),
            Container(
              child: const Text(
                "Swipe your AppCard to Start",
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
            Container(
              child: TextFormField(
                onChanged: (value) => setState(() {userID = int.parse(value);}),
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      )
    );
  }
}
