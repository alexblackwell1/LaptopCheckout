
import 'dart:convert';

import 'package:checkoutui/check_out/InstructionsPage.dart';
import 'package:checkoutui/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysql1/mysql1.dart';

class SwipePage extends StatefulWidget {
  const SwipePage({Key? key}) : super(key: key);

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  int userID = 0;
  int numComputers = -1;
  int returnHome = 0;

  @override
  Widget build(BuildContext context) {

    if (returnHome == 2) {
      return const OutInPage();
    }

    if (returnHome == 1) {
      goHome();
    }

    if (userID > 100000000 && userID < 1000000000) {
      sendStudent(userID.toString());
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
          future: getCount(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (numComputers == -1)  
                  const CircularProgressIndicator(),
                if (numComputers == 0)
                  const Text(
                    "Sorry, no laptops are available",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 32
                    ),
                  ),
                if (numComputers == 1)
                  const Text(
                    "1 laptop is available",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 32
                    ),
                  ),
                if (numComputers > 1)
                  Text(
                    numComputers.toString() + " laptops are available",
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 32
                    ),
                  ),
                const SizedBox(height: 35),
                if (numComputers > 0)
                  const Text(
                    "Swipe your AppCard to Start",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 32
                    ),
                  ),
                if (numComputers > 0)
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
                ),
              ],
            );
          }
        )
      )
    );
  }

  Future getCount() async {
    // print("start");
    // http://192.168.1.2/count.php
    String url = "http://192.168.1.2/count.php";
    // Map<String, String> headers = {
    //   "Accept": "application/json","Access-Control_Allow_Origin": "*"
    // };
    var needed;
    var response = await http.Client().get(Uri.parse(url), /*headers: headers*/)
        .then((value) {
          needed = value;
      // print("onThen> " + value.body.toString());
    }).onError((error, stackTrace) {
      // print("onError> " +
      //     error.toString() +
      //     " stackTrace> " +
      //     stackTrace.toString());
    });
    // print(needed.body.toString());
    setState(() {
      numComputers = int.parse(needed.body.toString());
      if (numComputers == 0) {
        returnHome = 1;
      }
    });
  }

  Future<void> sendStudent(String id) async {
    String url = "http://192.168.1.2/student.php";
    
    var needed;
    final response = await http.post(Uri.parse(url), body: {
	    "student": id
	  }).then((value) {
          needed = value;
    }).onError((error, stackTrace) {
      print("onError> " +
          error.toString() +
          " stackTrace> " +
          stackTrace.toString());
    });
  }

  Future<void> goHome() async {
    await Future.delayed(const Duration(seconds: 4));
    setState(() {
      returnHome = 2;
    });
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