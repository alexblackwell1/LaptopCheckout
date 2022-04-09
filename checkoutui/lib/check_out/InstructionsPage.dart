
import 'package:checkoutui/main.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InstructionsPage extends StatefulWidget {
  const InstructionsPage({Key? key}) : super(key: key);

  @override
  _InstructionsPageState createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {
  bool reset = false;

  Widget build(BuildContext context) {

    if (reset) {
      return const OutInPage();
    }
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    DateTime due = DateTime.now().add(const Duration(days: 3));
    String _due = DateFormat("MMMM d y").format(due);

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
        child: FutureBuilder(
          future: timer(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                  child: Text(
                    "Grab a Laptop\n"
                    "It will be due on "
                    + _due,
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 32,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ]
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