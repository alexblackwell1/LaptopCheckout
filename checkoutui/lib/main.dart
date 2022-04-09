import 'package:checkoutui/TermsPage.dart';
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
      home: TermsPage(),
    );
  }
}
