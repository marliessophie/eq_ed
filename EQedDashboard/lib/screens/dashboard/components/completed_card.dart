import 'package:admin/screens/dashboard/components/chart.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class CompletedCard extends StatelessWidget {
  const CompletedCard({Key? key, required this.level}) : super(key: key);

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
            "Performance Details",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: kDefaultPadding),
          Chart(
            text: level,
          ),
          for (var category in kCategories)
            CompletedLabel(
                text: category.name, index: kCategories.indexOf(category))
        ],
      ),
    );
  }
}

class CompletedLabel extends StatelessWidget {
  const CompletedLabel({
    Key? key,
    required this.index,
    required this.text,
  }) : super(key: key);

  final int index;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color:
                  kNeumorphicColors.elementAt(index % kNeumorphicColors.length),
            ),
          ),
          SizedBox(width: 20),
          Text(text),
        ],
      ),
    );
  }
}
