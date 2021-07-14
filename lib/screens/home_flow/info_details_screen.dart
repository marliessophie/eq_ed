import 'package:eq_ed/constants.dart';
import 'package:flutter/material.dart';

class InfoDetailsScreen extends StatefulWidget {
  static var id = 'info_details_screen';

  @override
  _InfoDetailsScreenState createState() => _InfoDetailsScreenState();
}

class _InfoDetailsScreenState extends State<InfoDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Hero(
            tag: "background-EQ'ed",
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: kGradientColorsEQed,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 16),
                  child: IconButton(
                    iconSize: 40,
                    icon: Icon(Icons.close),
                    color: Colors.white.withOpacity(0.9),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Hero(
                      tag: "image-EQ'ed",
                      child: Image.asset('images/penguin2.png',
                          height: screenHeight * 0.35)),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8),
                  child: Hero(
                    tag: "name-EQ'ed",
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        child: Text(
                          'EQ\'ed',
                          style: kLabelTextStyle.copyWith(
                            fontSize: 25.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 8, 32),
                  child: Text(
                    "I am here to help you get used to typical university workplace scenarios. " +
                        "You will be shown videos and be asked to record a response. " +
                        "Then I will give you some tips on how to make your response even better! " +
                        "We will focus on your shown soft skills. Click below to get started or " +
                        "find out more about how I developed these scenarios. \n",
                    style: kLabelTextStyle.copyWith(
                      fontSize: 20.0,
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
