
import 'package:flutter/material.dart';

class ThankPage extends StatefulWidget {
  const ThankPage({Key? key}) : super(key: key);

  @override
  State<ThankPage> createState() => _ThankPageState();
}

class _ThankPageState extends State<ThankPage> {
  int userID = 0;

  @override
  Widget build(BuildContext context) {

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
        child: const Text(
          "Thank You",
          style: TextStyle(
            color: Colors.white,
            fontSize: 32
          ),
        )
      )
    );
  }
}