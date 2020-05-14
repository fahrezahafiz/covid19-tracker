import 'package:covid19tracker/core/models/summary.dart';
import 'package:covid19tracker/core/viewmodels/all_viewmodels.dart';
import 'package:covid19tracker/ui/shared/inkwell_card.dart';
import 'package:covid19tracker/ui/ui_helper.dart';
import 'package:covid19tracker/core/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountryCard extends StatelessWidget {
  final int index;

  const CountryCard(this.index, {Key key}) : super(key: key);

  Widget buildNumber(int number, String label, Color numberColor) {
    return Column(
      children: <Widget>[
        Text(
          number.compact,
          style: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: numberColor),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final summary = Provider.of<HomeViewModel>(context).countrySummary[index];
    return InkWellCard(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 18),
      borderRadius: BorderRadius.circular(14),
      child: Column(
        children: <Widget>[
          Text('# ${index + 1}', style: TextStyle(color: Colors.black54)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(summary.flagImageUrl(size: 32)),
              UIHelper.hSpaceXSmall(),
              Text(summary.country,
                  style: TextStyle(fontSize: 18, color: Colors.black87)),
            ],
          ),
          UIHelper.vSpaceXSmall(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              buildNumber(summary.totalConfirmed, 'Confirmed', UIHelper.red),
              buildNumber(
                  summary.totalDeaths, 'Deaths', Colors.black.withOpacity(0.8)),
              buildNumber(summary.totalRecovered, 'Recovered', UIHelper.green),
            ],
          )
        ],
      ),
      onTap: () {},
    );
  }
}
