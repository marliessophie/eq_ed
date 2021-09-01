import 'package:admin/screens/dashboard/components/completed_card.dart';
import 'package:admin/screens/dashboard/components/recent_files.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class LevelCard extends StatelessWidget {
  const LevelCard({
    Key? key,
    required this.level,
  }) : super(key: key);

  final String level;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Level $level Game Data",
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: kPrimaryColor,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 6,
                child: RecentFiles(
                  level: level,
                ),
              ),
              Expanded(
                flex: 3,
                child: CompletedCard(
                  level: level,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
