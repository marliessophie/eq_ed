import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
    required this.text,
  }) : super(key: key);

  List<PieChartSectionData> getData() {
    if (text == "one") {
      return chartSelectionDataOne;
    } else if (text == "two") {
      return chartSelectionDataTwo;
    }
    return chartSelectionDataThree;
  }

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              sections: getData(),
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: kDefaultPadding),
                Text(
                  "User attempts",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text('Level $text'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> chartSelectionDataOne = [
  PieChartSectionData(
    color: kPrimaryColor,
    value: 83,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 17,
    showTitle: false,
    radius: 22,
  ),
];

List<PieChartSectionData> chartSelectionDataTwo = [
  PieChartSectionData(
    color: kPrimaryColor,
    value: 85,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 15,
    showTitle: false,
    radius: 22,
  ),
];

List<PieChartSectionData> chartSelectionDataThree = [
  PieChartSectionData(
    color: kPrimaryColor,
    value: 73,
    showTitle: false,
    radius: 22,
  ),
  PieChartSectionData(
    color: Color(0xFF26E5FF),
    value: 27,
    showTitle: false,
    radius: 22,
  ),
];
