
import 'package:checkoutui/main.dart';
import 'package:flutter/material.dart';

class ThankPage extends StatefulWidget {
  const ThankPage({Key? key}) : super(key: key);

  @override
  State<ThankPage> createState() => _ThankPageState();
}

class _ThankPageState extends State<ThankPage> {
  int userID = 0;
  bool reset = false;

  @override
  Widget build(BuildContext context) {

    if (reset) {
      return const OutInPage();
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
          future: timer(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              height: _height*.7,
              width: _width*.7,
              padding: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white, width: 2)
              ),
              child: const Text(
                "Thank You",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 32
                ),
              )
            );
          }
        )
      )
    );
  }

  Future<void> timer() async {
    await Future.delayed(const Duration(seconds: 10));
    setState(() {
      reset = true;
    });
  }
}