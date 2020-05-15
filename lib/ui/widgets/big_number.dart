import 'package:covid19tracker/core/viewmodels/all_viewmodels.dart';
import 'package:flutter/material.dart';
import 'package:covid19tracker/core/extensions.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BigNumber extends StatelessWidget {
  final String label;
  final int number;
  final Color numberColor;

  const BigNumber(this.label, this.number, {Key key, this.numberColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeViewModel>(context);
    return Column(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            color: Colors.black.withOpacity(0.7),
            fontSize: 18,
          ),
        ),
        Text(
          model.isBusy ? '...' : '${number.format}',
          style: TextStyle(
            color: numberColor,
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
