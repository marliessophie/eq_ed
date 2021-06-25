import 'package:eq_ed/components/design_components/character_widget.dart';
import 'package:eq_ed/constants.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  static var id = 'info_screen';

  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text('EQ\'ed | Info'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'I\'m EQ\'ed!',
                style: kNormalTextStyle.copyWith(
                  fontSize: 30.0,
                ),
              ),
              Text(
                'Find out more about me!',
                style: kNormalTextStyle.copyWith(
                  fontSize: 18.0,
                ),
              ),
              Expanded(
                child: CharacterWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
