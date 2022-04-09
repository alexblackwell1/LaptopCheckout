
import 'dart:convert';

import 'package:checkoutui/Env.dart';
import 'package:checkoutui/InstructionsPage.dart';
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

  @override
  Widget build(BuildContext context) {

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
                  CircularProgressIndicator(),
                if (numComputers >= 0)
                  Text(
                    numComputers.toString() + " laptops are available",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
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