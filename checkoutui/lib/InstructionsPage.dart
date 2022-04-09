
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InstructionsPage extends StatefulWidget {
  const InstructionsPage({Key? key}) : super(key: key);

  @override
  _InstructionsPageState createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {
  Widget build(BuildContext context) {
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
        child: Column(
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
                // + due.month.toString() + " "
                // + due.day.toString() + " "
                // + due.year.toString(),
                style: const TextStyle(
                  color: Colors.amber,
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ]
        )
      )
    );
  }
}