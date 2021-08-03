import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/account/app_settings.dart';
import 'package:vidflix/pages/account/calendar.dart';
import 'package:vidflix/pages/account/kalendar.dart';
import 'package:vidflix/pages/account/change_language.dart';
//import 'package:vidflix/pages/account/privacy_policy.dart';
import 'package:vidflix/pages/home/home.dart';
import 'package:vidflix/pages/account/edit_profile.dart';
import 'package:vidflix/pages/login_signup/login.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future getData() async {
      var url = 'https://portal.mywau.com/dev/flutter/php/read.php';
      var response = await http.get(url);
      return json.decode(response.body);
    }

    thanksDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 220.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 70.0,
                    width: 70.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35.0),
                      border: Border.all(color: redColor, width: 1.0),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 40.0,
                      color: redColor,
                    ),
                  ),
                  heightSpace,
                  Text(
                    AppLocalizations.of(context)
                        .translate('accountPage', 'thanksForActivatingString'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontFamily: 'Mukta',
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0,
                    ),
                  ),
                  heightSpace,
                ],
              ),
            ),
          );
        },
      );

      Future.delayed(const Duration(milliseconds: 3000), () {
        setState(() {
          Navigator.push(context,
              PageTransition(type: PageTransitionType.fade, child: Home()));
        });
      });
    }

    paymentMethodDialog() {
      int selectedRadioPayment = 0;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, setState) {
              setSelectedRadioPayment(int val) {
                setState(() {
                  selectedRadioPayment = val;
                });
              }

              return Dialog(
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                child: Container(
                  height: 430.0,
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context).translate(
                            'accountPage', 'choosePaymentMethodString'),
                        style: TextStyle(
                          fontFamily: 'Mukta',
                          fontSize: 21.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        width: width - 40.0,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: RadioListTile(
                          value: 0,
                          groupValue: selectedRadioPayment,
                          title: Text(
                            "Credit / Debit Card",
                            style: paymentDialogueListTileTextStyle,
                          ),
                          onChanged: (val) {
                            setSelectedRadioPayment(val);
                          },
                          activeColor: redColor,
                          secondary: Image(
                            image: AssetImage(
                              'assets/payment_icon/card.png',
                            ),
                            height: 45.0,
                            width: 45.0,
                          ),
                        ),
                      ),
                      Divider(
                        height: 1.0,
                      ),
                      Container(
                        width: width - 40.0,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: RadioListTile(
                          value: 3,
                          groupValue: selectedRadioPayment,
                          title: Text(
                            "PayPal",
                            style: paymentDialogueListTileTextStyle,
                          ),
                          onChanged: (val) {
                            setSelectedRadioPayment(val);
                          },
                          activeColor: redColor,
                          secondary: Image(
                            image: AssetImage(
                              'assets/payment_icon/paypal.png',
                            ),
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                      ),
                      Divider(
                        height: 1.0,
                      ),
                      Container(
                        width: width - 40.0,
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: RadioListTile(
                          value: 4,
                          groupValue: selectedRadioPayment,
                          title: Text(
                            "Google Wallet",
                            style: paymentDialogueListTileTextStyle,
                          ),
                          onChanged: (val) {
                            setSelectedRadioPayment(val);
                          },
                          activeColor: redColor,
                          secondary: Image(
                            image: AssetImage(
                              'assets/payment_icon/google_wallet.png',
                            ),
                            height: 40.0,
                            width: 40.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
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
                                style: headingStyle,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              thanksDialog();
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
                                    .translate('accountPage', 'payString'),
                                style: headingStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }

    choosePlanDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: Container(
              height: 300.0,
              padding: EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)
                        .translate('accountPage', 'vidFlixPremiumString'),
                    style: TextStyle(
                      fontFamily: 'Mukta',
                      fontSize: 21.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  heightSpace,
                  InkWell(
                    onTap: () => paymentMethodDialog(),
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: width,
                      height: 100.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.cyan[100],
                      ),
                      child: Container(
                        width: width,
                        height: 100.0,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 0.0,
                              left: 0.0,
                              child: Container(
                                width: width,
                                height: 100.0,
                                padding: EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          '\$499',
                                          style: TextStyle(
                                            fontSize: 24.0,
                                            fontFamily: 'Mukta',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        Text(
                                          '/ year',
                                          style: descriptionStyle,
                                        ),
                                      ],
                                    ),
                                    heightSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('accountPage',
                                                  'chargedYearlyString'),
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 13.0,
                                            fontFamily: 'Mukta',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                        widthSpace,
                                        Container(
                                          height: 5.0,
                                          width: 5.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(2.5),
                                              color: Colors.grey[500]),
                                        ),
                                        widthSpace,
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('accountPage',
                                                  'nonRefundableString'),
                                          style: TextStyle(
                                            color: Colors.grey[500],
                                            fontSize: 13.0,
                                            fontFamily: 'Mukta',
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0.0,
                              right: 0.0,
                              child: Container(
                                width: 50.0,
                                height: 60.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(10.0)),
                                  color: redColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '58%',
                                      style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 16.0,
                                        fontFamily: 'Mukta',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'OFF',
                                      style: TextStyle(
                                        color: whiteColor,
                                        fontSize: 16.0,
                                        fontFamily: 'Mukta',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  heightSpace,
                  InkWell(
                    onTap: () => paymentMethodDialog(),
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      width: width,
                      height: 100.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.green[100],
                      ),
                      child: Container(
                        width: width,
                        height: 100.0,
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(
                                  '\$49',
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontFamily: 'Mukta',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '/ month',
                                  style: descriptionStyle,
                                ),
                              ],
                            ),
                            heightSpace,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context).translate(
                                      'accountPage', 'chargedMonthlyString'),
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 13.0,
                                    fontFamily: 'Mukta',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                widthSpace,
                                Container(
                                  height: 5.0,
                                  width: 5.0,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2.5),
                                      color: Colors.grey[500]),
                                ),
                                widthSpace,
                                Text(
                                  AppLocalizations.of(context).translate(
                                      'accountPage', 'nonRefundableString'),
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 13.0,
                                    fontFamily: 'Mukta',
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    logoutDialogue() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
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
                              logoutUser();
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

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.6),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(1.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              automaticallyImplyLeading: false,
              title: Text(
                AppLocalizations.of(context)
                    .translate('accountPage', 'accountString'),
                style: headingStyle,
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    logoutDialogue();
                  },
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('accountPage', 'logoutString'),
                    style: linkStyle,
                  ),
                ),
              ],
            ),
            body: FutureBuilder(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return snapshot.hasData
                      ? ListView(
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            heightSpace,
                            Container(
                              width: width,
                              padding: EdgeInsets.only(
                                  right: fixPadding, left: fixPadding),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                    child: new Image.network(
                                        snapshot.data[2]["image"].toString()),
                                  ),
                                  heightSpace,
                                  Text(
                                    'John Smith',
                                    style: headingStyle,
                                  ),
                                  heightSpace,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        height: 25.0,
                                        width: 25.0,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                          image: AssetImage(
                                              'assets/silver_crown.png'),
                                          fit: BoxFit.contain,
                                        )),
                                      ),
                                      widthSpace,
                                      Text(
                                        AppLocalizations.of(context).translate(
                                            'accountPage', 'notPremiumString'),
                                        style: descriptionStyle,
                                      ),
                                    ],
                                  ),
                                  heightSpace,
                                  InkWell(
                                    onTap: () => choosePlanDialog(),
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      width: width - 40.0,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: Colors.red,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            height: 35.0,
                                            width: 35.0,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/gold_crown.png'),
                                              fit: BoxFit.contain,
                                            )),
                                          ),
                                          widthSpace,
                                          Text(
                                            'Get ECJFlix Premium',
                                            // AppLocalizations.of(context)
                                            //     .translate('accountPage',
                                            //         'getECJFlixPremiumString'),
                                            style: headingStyle,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  heightSpace,
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: EditProfile()));
                                    },
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      width: width - 40.0,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: Colors.blue,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context).translate(
                                            'accountPage', 'editProfileString'),
                                        style: headingStyle,
                                      ),
                                    ),
                                  ),
                                  heightSpace,
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: AppSettings()));
                                    },
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      width: width - 40.0,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: Colors.teal,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context).translate(
                                            'accountPage', 'appSettingsString'),
                                        style: headingStyle,
                                      ),
                                    ),
                                  ),
                                  heightSpace,
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              child: Calendar()));
                                    },
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      width: width - 40.0,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: Colors.orange,
                                      ),
                                      child: Text(
                                        'Calendar Bursa',
                                        style: headingStyle,
                                      ),
                                    ),
                                  ),
                                  heightSpace,
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              child: ChangeLanguage()));
                                    },
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      width: width - 40.0,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: Colors.indigo,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context).translate(
                                            'accountPage',
                                            'changeLanguageString'),
                                        style: headingStyle,
                                      ),
                                    ),
                                  ),
                                  heightSpace,
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              child: Kalendar()));
                                    },
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Container(
                                      width: width - 40.0,
                                      height: 50.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        color: Colors.cyan,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context).translate(
                                            'accountPage', 'privacyPolicy'),
                                        style: headingStyle,
                                      ),
                                    ),
                                  ),
                                  heightSpace,
                                ],
                              ),
                            ),
                          ],
                        )
                      : CircularProgressIndicator();
                }),
          ))
        ],
      ),
    );
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.push(context,
        PageTransition(type: PageTransitionType.rightToLeft, child: Login()));
  }
}
