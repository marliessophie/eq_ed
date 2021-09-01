import 'package:admin/models/user_data.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class RecentFiles extends StatelessWidget {
  final String level;

  const RecentFiles({
    Key? key,
    required this.level,
  }) : super(key: key);

  List getData() {
    print('here');
    if (level == 'one') {
      return userFilesOne;
    } else if (level == 'two') {
      return userFilesTwo;
    }
    return userFilesThree;
  }

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
            "User Performance",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            width: double.infinity,
            child: DataTable2(
              columnSpacing: kDefaultPadding,
              minWidth: 600,
              dataRowHeight: 100,
              columns: [
                DataColumn(
                  label: Text("Metric"),
                ),
                DataColumn(
                  label: Text("Value"),
                ),
                DataColumn(
                  label: Text("Description"),
                ),
              ],
              rows: List.generate(
                userFilesOne.length,
                (index) => recentUserData(getData()[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentUserData(UserData userData) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            SizedBox(
              child: userData.icon,
              height: 30,
              width: 30,
            ),
            SizedBox(
              width: 10,
            ),
            SizedBox(
              child: Center(
                child: Text(userData.metric!,
                    style: TextStyle(
                      fontSize: 14.0,
                    )),
              ),
              height: 100,
              width: 150,
            ),
          ],
        ),
      ),
      DataCell(
        Text(userData.value!),
      ),
      DataCell(
        Text(userData.description!),
      ),
    ],
  );
}
