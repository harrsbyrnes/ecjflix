//import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/login_signup/signup.dart';
import 'package:vidflix/pages/login_signup/forgot_password.dart';
import 'package:vidflix/pages/home/home.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DateTime currentBackPressTime;
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  checkLogin() async {
    var url = "https://portal.mywau.com/dev/flutter/php/login.php";
    var response = await http.post(url, body: {
      "email": email.text.trim(),
      "password": password.text.trim(),
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    var userid = jsonData['userid'];
    var name = jsonData['name'];
    var phone_no = jsonData['phone_no'];
    if (jsonString == 'Success') {
      myToast(jsonString);
      saveSession(userid, name, phone_no);
      Navigator.push(context,
          PageTransition(type: PageTransitionType.rightToLeft, child: Home()));
    } else if (jsonString == 'Email not found, please register') {
      myToast(jsonString);
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: Signup()));
    } else {
      myToast(jsonString);
    }
  }

  saveSession(userid, name, phone_no) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('email', email.text.trim());
    prefs.setString('userid', userid.trim());
    prefs.setString('name', name.trim());
    prefs.setString('phone_no', phone_no.trim());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage('assets/ecj.png'), fit: BoxFit.cover),
      // ),

      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              child: new Image.network('https://i.imgur.com/faymREZ.png'),
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
            child: WillPopScope(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Padding(
                      padding: EdgeInsets.only(
                          top: fixPadding * 2,
                          left: fixPadding * 2,
                          right: fixPadding * 2.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('loginPage', 'welcomeBackString'),
                        style: loginBigTextStyle,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: fixPadding * 2, right: fixPadding * 2.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .translate('loginPage', 'loginYourAccountString'),
                        style: thickStyle,
                      ),
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Padding(
                      padding: EdgeInsets.only(
                          right: fixPadding * 2, left: fixPadding * 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200].withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          controller: email,
                          style: headingStyle,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 20.0, right: 20.0),
                            hintText: AppLocalizations.of(context)
                                .translate('loginPage', 'emailString'),
                            hintStyle: headingStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    heightSpace,
                    Padding(
                      padding: EdgeInsets.only(
                          right: fixPadding * 2, left: fixPadding * 2),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200].withOpacity(0.3),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: TextField(
                          controller: password,
                          style: headingStyle,
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 20.0, right: 20.0),
                            hintText: AppLocalizations.of(context)
                                .translate('loginPage', 'passwordString'),
                            hintStyle: headingStyle,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    heightSpace,
                    heightSpace,
                    Padding(
                      padding: EdgeInsets.only(
                          right: fixPadding * 2, left: fixPadding * 2),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          checkLogin();
                        },
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight,
                              stops: [0.1, 0.5, 0.9],
                              colors: [
                                Colors.red[300].withOpacity(0.8),
                                Colors.red[500].withOpacity(0.8),
                                Colors.red[800].withOpacity(0.8),
                              ],
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('loginPage', 'loginString'),
                            style: headingStyle,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(fixPadding),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: ForgotPassword()));
                        },
                        child: Padding(
                          padding: EdgeInsets.all(fixPadding),
                          child: Text(
                            AppLocalizations.of(context)
                                .translate('loginPage', 'forgotPasswordString'),
                            style: headingStyle,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: fixPadding * 2, left: fixPadding * 2),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30.0),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: Signup()));
                        },
                        child: Container(
                          height: 50.0,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.bottomRight,
                              stops: [0.1, 0.5, 0.9],
                              colors: [
                                Colors.red[300].withOpacity(0.8),
                                Colors.red[500].withOpacity(0.8),
                                Colors.red[800].withOpacity(0.8),
                              ],
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context).translate(
                                'loginPage', 'dontHaveAccountString'),
                            style: headingStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              onWillPop: () async {
                bool backStatus = onWillPop();
                if (backStatus) {}
                return false;
              },
            ),
          ),
        ],
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
            .translate('loginPage', 'pressBackOnceAgainString'),
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  // void logoutUser() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs?.clear();
  //   exit(0);
  // }

  myToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }
}
