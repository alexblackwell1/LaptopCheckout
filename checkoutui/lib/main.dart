
import 'package:checkoutui/check_in/SwipeIn.dart';
import 'package:checkoutui/check_out/TermsPage.dart';
import 'package:flutter/material.dart';

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
      home: const OutInPage(),
    );
  }
}

class OutInPage extends StatefulWidget {
  const OutInPage({Key? key}) : super(key: key);

  @override
  State<OutInPage> createState() => _OutInPageState();
}

class _OutInPageState extends State<OutInPage> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    if (page == 1) {
      return const SwipeInPage();
    }
    if (page == 2) {
      return const TermsPage();
    }

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
          children: <Widget>[
            Container(
              width: 400,
              height: 85,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber, width: 2)
              ),
              child: TextButton(
                onPressed: () {setState(() {
                  page = 1;
                });},
                child: const Text(
                  "Check-in Laptop",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 28
                  ),
                ), 
              )
            ),
            const SizedBox(height: 35),
            Container(
              width: 400,
              height: 85,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber, width: 2)
              ),
              child: TextButton(
                onPressed: () {setState(() {
                  page = 2;
                });},
                child: const Text(
                  "Checkout Laptop",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 28
                  ),
                ), 
              )
            )
          ]
        )
      )
    );
  }
}
