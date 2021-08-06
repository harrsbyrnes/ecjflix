import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/category/more_list.dart';
import 'package:vidflix/pages/home/home_component/best_of_kids.dart';
import 'package:vidflix/pages/home/home_component/explore_by_genre.dart';
import 'package:vidflix/pages/home/home_component/main_slider.dart';
import 'package:vidflix/pages/home/home_component/multiplex_movies.dart';
import 'package:vidflix/pages/home/home_component/popular_movies.dart';
import 'package:vidflix/pages/home/home_component/special_latest_movies.dart';
import 'package:vidflix/pages/account/account.dart';
import 'package:vidflix/pages/login_signup/login.dart';
import 'package:vidflix/pages/notification.dart';
import 'package:vidflix/pages/Ejournal.dart';
import 'package:vidflix/pages/account/calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}

class _HomeMainState extends State<HomeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0.0,
        automaticallyImplyLeading: true,
        title: Text(
          'ECJ Flix',
          style: headingStyle,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications, color: whiteColor),
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.size,
                      alignment: Alignment.bottomCenter,
                      child: Notifications()));
            },
          ),
        ],
      ),
      drawer: SideDrawer(),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          MainSlider(),
          heightSpace,
          Padding(
            padding: EdgeInsets.all(fixPadding),
            child: Text(
              AppLocalizations.of(context)
                  .translate('homePage', 'exploreByGenreString'),
              style: headingStyle,
            ),
          ),
          ExploreByGernre(),
          heightSpace,
          Padding(
            padding: EdgeInsets.all(fixPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)
                      .translate('homePage', 'specialAndLatestMoviesString'),
                  style: headingStyle,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: MoreList()));
                  },
                  child: Text(
                      AppLocalizations.of(context)
                          .translate('homePage', 'moreString'),
                      style: linkStyle),
                ),
              ],
            ),
          ),
          SpecialLatestMoviesList(),
          heightSpace,
          Padding(
            padding: EdgeInsets.all(fixPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sembang Saham PKP 2.0',
                  // AppLocalizations.of(context)
                  //     .translate('homePage', 'multiplexMoviesString'),
                  style: headingStyle,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: MoreList()));
                  },
                  child: Text(
                      AppLocalizations.of(context)
                          .translate('homePage', 'moreString'),
                      style: linkStyle),
                ),
              ],
            ),
          ),
          MultiPlexMoviesList(),
          heightSpace,
          Padding(
            padding: EdgeInsets.all(fixPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'We Can Yumcha 2.0',
                  // AppLocalizations.of(context)
                  //     .translate('homePage', 'popularMoviesString'),
                  style: headingStyle,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: MoreList()));
                  },
                  child: Text(
                      AppLocalizations.of(context)
                          .translate('homePage', 'moreString'),
                      style: linkStyle),
                ),
              ],
            ),
          ),
          PopularMoviesList(),
          heightSpace,
          Padding(
            padding: EdgeInsets.all(fixPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sembang Saham 2.0',
                  // AppLocalizations.of(context)
                  //     .translate('homePage', 'bestOfKidsString'),
                  style: headingStyle,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.bottomToTop,
                            child: MoreList()));
                  },
                  child: Text(
                      AppLocalizations.of(context)
                          .translate('homePage', 'moreString'),
                      style: linkStyle),
                ),
              ],
            ),
          ),
          BestOfKidsList(),
          heightSpace,
        ],
      ),
    );
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Menu',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle_sharp),
            title: Text('Account'),
            onTap: () => {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: Account()))
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today_rounded),
            title: Text('Calendar'),
            onTap: () => {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: Calendar()))
            },
          ),
          ListTile(
            leading: Icon(Icons.book_rounded),
            title: Text('E-Journal'),
            onTap: () => {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft, child: EJournal()))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {logoutDialogue(context, width)},
          ),
        ],
      ),
    );
  }

  logoutDialogue(context, width) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return Dialog(
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Wrap(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)
                          .translate('accountPage', 'sureLogoutString'),
                      style: TextStyle(
                        fontFamily: 'Mukta',
                        fontSize: 21.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('accountPage', 'cancelString'),
                              style: TextStyle(
                                fontFamily: 'Mukta',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            logoutUser(context);
                          },
                          child: Container(
                            width: (width / 3.5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: redColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              AppLocalizations.of(context)
                                  .translate('accountPage', 'logoutString'),
                              style: TextStyle(
                                fontFamily: 'Mukta',
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void logoutUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.push(context,
        PageTransition(type: PageTransitionType.rightToLeft, child: Login()));
  }
}
