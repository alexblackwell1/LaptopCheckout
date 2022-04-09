
import 'package:checkoutui/check_out/SwipePage.dart';
import 'package:flutter/material.dart';

class TermsPage extends StatefulWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  _TermsPageState createState() => _TermsPageState();
}

class _TermsPageState extends State<TermsPage> {
  bool pageChange = false;

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    if (pageChange) {
      return const SwipePage();
    }

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
              child: SingleChildScrollView(
                child: Container(
                  height: 615,
                  width: _width*.6,
                  child: getTandC()
                )
              )
            ),
            const SizedBox(
              height: 50
            ),
            Container(
              width: _width * .4,
              height: _height*.075,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber, width: 4)
              ),
              child: TextButton(
                onPressed: () {setState(() {
                  pageChange = true;
                });},
                child: const Text(
                  "Agree and Continue",
                  style: TextStyle(
                    color: Colors.amber,
                    fontSize: 30
                  ),
                ),
              ),
            )
          ]
        )
      )
    );
  }

  Widget getTandC() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        // About
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "About this service\n",
              style: header()
            ),
            TextSpan(
              text: "The Technology Checkout Desk is a service desk that allows patrons to check out digital equipment "
                + "and accessories for personal use. It is located on the Lower Level of the Belk Library and Information "
                + "Commons, next to the main stairwell and adjacent to the Digital Media Studio. Refer to the floor plan "
                + "for a detailed map of the Lower Level, as well as the Technology Checkout Desk calendar (click on "
                + "“Technology Checkout Desk” tab) for our updated hours.\n",
              style: body()
            ),
          ])
        ),
        // checkout
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "Check-out policies and procedures\n",
              style: header()
            ),
            TextSpan(
              text: "No reservations: We do not reserve equipment for individuals or classes, all items are first come/first serve.\n"
                "Returns: Equipment must be returned to the Technology Checkout Desk during open hours.\n"
                "Renewals: No online or over the phone renewals. Equipment must be returned to the desk for renewal.\n"
                "Responsibility: You are responsible for overdue, lost or damaged equipment and peripherals. Overdue fines "
                "are automatically applied to your Student Account for all equipment returned late (\$5 a day per checked "
                "out item for daily equipment).\n",
                // "\nBilling: Keeping items out for seven days past their initial due date will result in being billed for the "
                // "full cost of the item.  Returning it will remove this bill and replace it with overdue fines.\n",
              style: body()
            ),
          ])
        ),
        // Billing
        RichText(text: TextSpan(children: [
          TextSpan(
            text: "\nBilling: Keeping items out for seven days past their initial due date will result in being billed for the "
              "full cost of the item.  Returning it will remove this bill and replace it with overdue fines.\n",
            style: body()
          ),
        ])),
        // suggest
        RichText(
          text: TextSpan(children: [
            TextSpan(
              text: "\nSuggest equipment for purchase\n",
              style: header()
            ),
            TextSpan(
              text: "Interested in suggesting equipment for the Technology Checkout Desk to circulate?  Please do so using the "
                "Technology Checkout Desk Equipment Request form and we will take it under consideration.",
              style: body()
            ),
          ])
        ),
        const SizedBox(height: 15,)
      ],
    );
  }

  TextStyle header() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 24
    );
  }
  TextStyle body() {
    return const TextStyle(
      color: Colors.amber,
      fontSize: 18
    );
  }
}