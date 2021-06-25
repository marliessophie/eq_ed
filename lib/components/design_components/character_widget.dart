import 'package:eq_ed/components/design_components/character_card_background_clipper.dart';
import 'package:eq_ed/constants.dart';
import 'package:eq_ed/screens/home_flow/info_details_screen.dart';
import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 350),
                pageBuilder: (context, _, __) => InfoDetailsScreen()));
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CharacterCardBackgroundClipper(),
              child: Container(
                height: 0.55 * screenHeight,
                width: 0.9 * screenWidth,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  colors: kGradientColors,
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                )),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, -0.2),
            child: Hero(
              tag: "image-EQ'ed",
              child: Image(
                image: AssetImage('images/penguin2.png'),
                height: screenHeight * 0.55,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 48, right: 16, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Hero(
                  tag: 'name-EQ\'ed',
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
                Text(
                  "Tap to Read more",
                  style: kLabelTextStyle.copyWith(
                    fontSize: 18.0,
                    color: Colors.white,
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
