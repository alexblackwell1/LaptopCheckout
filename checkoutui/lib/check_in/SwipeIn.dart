
import 'package:checkoutui/check_in/HookInPage.dart';
import 'package:checkoutui/check_in/ThankPage.dart';
import 'package:checkoutui/main.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

class SwipeInPage extends StatefulWidget {
  const SwipeInPage({Key? key}) : super(key: key);

  @override
  State<SwipeInPage> createState() => _SwipeInPageState();
}

class _SwipeInPageState extends State<SwipeInPage> {
  int userID = 0;
  int inSystem = 0;

  @override
  Widget build(BuildContext context) {

    if (userID > 100000000 && userID < 1000000000) {
      sendStudent(userID.toString());
    }

    if (inSystem >= 1) {
      return const HookInPage();
    }
    if (inSystem == -1) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
                "Swipe to check in",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 24
                ),
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

  Future<void> sendStudent(String id) async {
    String url = "http://192.168.1.2/verify.php";

    var request = await HttpClient().getUrl(Uri.parse(url));
    // sends the request
    var response = await request.close(); 

    var needed;
    // transforms and prints the response
    await for (var contents in response.transform(Utf8Decoder())) {
      needed = contents;
      print(contents);
    }
    
    setState(() {
      if (int.parse(needed) == 10) {
        inSystem = -1;
      }
      else {
        inSystem = 1;
      }
    });
    
    /*
    var needed;
    final query = await http.post(Uri.parse(url), body: {
	    "student": id
	  }).then((value) {
          needed = value;
    }).onError((error, stackTrace) {
      print("onError> " +
          error.toString() +
          " stackTrace> " +
          stackTrace.toString());
    });

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
    print(needed.body.toString());
    setState(() {
      inSystem = int.parse(needed.body.toString());
      if (inSystem == 0) {
        inSystem = -1;
      }
    });
    */
  }
}