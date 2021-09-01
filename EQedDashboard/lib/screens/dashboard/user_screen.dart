import 'package:admin/screens/dashboard/components/level_data.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/user_header.dart';

class UserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            UserHeader(),
            SizedBox(height: kDefaultPadding),
            LevelData(),
          ],
        ),
      ),
    );
  }
}
