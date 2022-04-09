
import 'package:checkoutui/InstructionsPage.dart';
import 'package:flutter/material.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  int userID = 0;

  @override
  Widget build(BuildContext context) {

    if (userID > 100000000 && userID < 1000000000) {
      return const InstructionsPage();
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
        child: FutureBuilder<dynamic>(
          future: null, // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return defaultView();
          }
        )
      )
    );
  }

  Widget defaultView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Container(
          child: const Text(
            "Swipe your AppCard to Start",
            style: TextStyle(
              color: Colors.white,
            ),
          )
        ),
        TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Swipe or enter student ID',
          ),
          onChanged: (value) {
            setState(() {
              userID = int.tryParse(value)!;
            });
          },
        )
      ],
    );
  }
}