import 'dart:io';
import 'dart:ui';

import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/account/account.dart';
import 'package:vidflix/pages/home/home_main.dart';
import 'package:vidflix/pages/search.dart';
import 'package:vidflix/pages/watch_later.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex;
  DateTime currentBackPressTime;
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 20.0,
            sigmaY: 20.0,
          ),
          child: BubbleBottomBar(
            backgroundColor: Colors.grey.shade800.withOpacity(0.2),
            hasNotch: false,
            opacity: 0.2,
            hasInk: true,
            inkColor: Colors.red[200],
            currentIndex: currentIndex,
            onTap: changePage,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(
                    16)), //border radius doesn't work when the notch is enabled.
            elevation: 8,
            items: <BubbleBottomBarItem>[
              BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                title: Text(
                    AppLocalizations.of(context)
                        .translate('bottomBar', 'homeString'),
                    style: TextStyle(fontSize: 12.0)),
              ),
              BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                activeIcon: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
                title: Text(
                    AppLocalizations.of(context)
                        .translate('bottomBar', 'searchString'),
                    style: TextStyle(fontSize: 12.0)),
              ),
              BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                ),
                activeIcon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                title: Text(
                    AppLocalizations.of(context)
                        .translate('bottomBar', 'watchLaterString'),
                    style: TextStyle(fontSize: 12.0)),
              ),
              BubbleBottomBarItem(
                backgroundColor: Colors.red,
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                activeIcon: Icon(
                  Icons.person,
                  color: Colors.red,
                ),
                title: Text(
                    AppLocalizations.of(context)
                        .translate('bottomBar', 'accountString'),
                    style: TextStyle(fontSize: 12.0)),
              ),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        child: (currentIndex == 0)
            ? HomeMain()
            : (currentIndex == 1)
                ? Search()
                : (currentIndex == 2)
                    ? WatchLater()
                    : Account(),
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: AppLocalizations.of(context)
            .translate('bottomBar', 'pressBackOnceAgainString'),
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
