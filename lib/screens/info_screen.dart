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
    );
  }
}
