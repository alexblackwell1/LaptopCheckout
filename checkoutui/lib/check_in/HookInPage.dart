
import 'package:checkoutui/check_in/ThankPage.dart';
import 'package:flutter/material.dart';

class HookInPage extends StatefulWidget {
  const HookInPage({Key? key}) : super(key: key);

  @override
  State<HookInPage> createState() => _HookInPageState();
}

class _HookInPageState extends State<HookInPage> {
  bool nextPage = false;

  @override
  Widget build(BuildContext context) {

    if (nextPage) {
      return const ThankPage();
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
        alignment: Alignment.center,
        child: FutureBuilder(
          future: check(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return const Text(
              "Please plug in the laptop",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28
              ),
            );
          }
        )
      )
    );
  }

  Future check() async {
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      nextPage = true;
    });
  }
}


