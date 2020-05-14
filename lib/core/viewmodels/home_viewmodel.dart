import 'package:covid19tracker/core/locator.dart';
import 'package:covid19tracker/core/models/all_models.dart';
import 'package:covid19tracker/core/models/result.dart';
import 'package:covid19tracker/core/services/api.dart';
import 'package:covid19tracker/core/viewmodels/base_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum CountrySort { Confirmed, Deaths, Recovered }

class HomeViewModel extends BaseViewModel {
  Api _api = locator<Api>();
  GlobalSummary globalSummary = GlobalSummary(
    totalConfirmed: 0,
    totalDeaths: 0,
    totalRecovered: 0,
    newConfirmed: 0,
    newDeaths: 0,
    newRecovered: 0,
  );
  List<CountrySummary> countrySummary = List<CountrySummary>();

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  ScrollController countryListController = ScrollController();
  RefreshController refreshController = RefreshController();

  Future getSummary() async {
    setBusy(true);
    Result result = await _api.getSummary('Global');
    if (result.type == ResultType.Success) {
      var data = result.data;
      globalSummary = GlobalSummary.fromJson(data['Global']);
      countrySummary = List<CountrySummary>.from(
        data['Countries'].map((x) => CountrySummary.fromJson(x)),
      );
      countrySummary
          .sort((b, a) => a.totalConfirmed.compareTo(b.totalConfirmed));
    }
    refreshController.refreshCompleted();
    setBusy(false);

    return result;
  }

  void setCurrentIndex(int newIndex) {
    if (newIndex == 1)
      Future.delayed(Duration(milliseconds: 100), () {
        countryListController.animateTo(0.0,
            duration: Duration(milliseconds: 800), curve: Curves.easeOut);
      });

    currentIndex = newIndex;
    notifyListeners();
  }
}
