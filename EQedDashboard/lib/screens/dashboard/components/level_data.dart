import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/level_card.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class LevelData extends StatelessWidget {
  const LevelData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
              LevelCard(
                level: 'One',
              ),
              SizedBox(height: kDefaultPadding),
              LevelCard(
                level: 'Two',
              ),
              SizedBox(height: kDefaultPadding),
              LevelCard(
                level: 'Three',
              ),
              SizedBox(height: kDefaultPadding),
              if (Responsive.isMobile(context))
                SizedBox(height: kDefaultPadding),
            ],
          ),
        ),
        if (!Responsive.isMobile(context)) SizedBox(width: kDefaultPadding),
      ],
    );
  }
}
