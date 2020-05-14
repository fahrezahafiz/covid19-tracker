import 'package:covid19tracker/core/models/result.dart';
import 'package:covid19tracker/core/viewmodels/all_viewmodels.dart';
import 'package:covid19tracker/ui/shared/inkwell_card.dart';
import 'package:covid19tracker/ui/ui_helper.dart';
import 'package:covid19tracker/ui/views/base_view.dart';
import 'package:covid19tracker/core/extensions.dart';
import 'package:covid19tracker/ui/widgets/big_number.dart';
import 'package:covid19tracker/ui/widgets/country_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeView extends StatelessWidget {
  final _tabs = [GlobalTab(), CountriesTab()];

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      onModelReady: (model) async {
        Result result = await model.getSummary();
        if (result.type == ResultType.Error)
          model.showSnackBar(context, result);
      },
      dispose: (model) {
        model.countryListController.dispose();
      },
      builder: (context, model, child) {
        return Scaffold(
          key: model.scaffoldKey,
          backgroundColor: Colors.grey[100],
          drawer: MainDrawer(),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: UIHelper.red,
            currentIndex: model.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Icon(FontAwesomeIcons.globeAmericas),
                  ),
                  title: Text('World')),
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Icon(FontAwesomeIcons.flag),
                  ),
                  title: Text('Countries')),
            ],
            onTap: (index) => model.setCurrentIndex(index),
          ),
          body: SafeArea(child: _tabs[model.currentIndex]),
        );
      },
    );
  }
}

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),
          child: Column(
            children: <Widget>[
              UIHelper.vSpaceMedium(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset('assets/img/bacteria.svg', width: 70),
                  UIHelper.hSpaceSmall(),
                  Text(
                    'Covid-19\nTracker',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlobalTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeViewModel>(context);
    final summary = model.globalSummary;
    return SmartRefresher(
      controller: model.refreshController,
      onRefresh: () => model.getSummary(),
      child: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
            child: Stack(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.menu, color: Colors.black54),
                    onPressed: () =>
                        model.scaffoldKey.currentState.openDrawer()),
                Center(
                    child:
                        SvgPicture.asset('assets/img/bacteria.svg', width: 50)),
              ],
            ),
          ),
          UIHelper.vSpaceMedium(),
          BigNumber('Total Confirmed', summary.totalConfirmed,
              numberColor: UIHelper.red),
          UIHelper.vSpaceSmall(),
          BigNumber('Total Deaths', summary.totalDeaths,
              numberColor: Colors.black.withOpacity(0.8)),
          UIHelper.vSpaceSmall(),
          BigNumber('Total Recovered', summary.totalRecovered,
              numberColor: UIHelper.green)
        ],
      ),
    );
  }
}

class CountriesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeViewModel>(context);
    final countrySummary = model.countrySummary;
    return Scrollbar(
      child: ListView.builder(
        controller: model.countryListController,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: countrySummary.length + 2,
        itemBuilder: (context, index) {
          if (index == 0)
            return ListSorter();
          else if (index == countrySummary.length + 1)
            return UIHelper.vSpaceMedium();
          else
            return CountryCard(index - 1);
        },
      ),
    );
  }
}

class ListSorter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
