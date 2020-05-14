import 'package:covid19tracker/core/models/result.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';

class BaseViewModel extends ChangeNotifier {
  bool _busy = false;

  bool get isBusy => _busy;

  void setBusy(bool val) {
    _busy = val;
    notifyListeners();
  }

  void showSnackBar(BuildContext context, Result result) {
    showFlash(
      duration: Duration(seconds: 2),
      context: context,
      builder: (_, controller) {
        return Flash(
          style: FlashStyle.floating,
          margin: EdgeInsets.all(10),
          borderRadius: BorderRadius.circular(10),
          backgroundColor: Colors.black87,
          controller: controller,
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: FlashBar(
              icon: Icon(result.iconData, color: result.color),
              message: Text(result.message),
            ),
          ),
        );
      },
    );
  }
}
