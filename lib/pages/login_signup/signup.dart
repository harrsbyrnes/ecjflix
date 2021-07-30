// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:vidflix/constant/constant.dart';
// import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/login_signup/login.dart';
// import 'package:vidflix/pages/login_signup/signup.dart';
//import 'package:vidflix/pages/login_signup/forgot_password.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:vidflix/pages/home/home.dart';
// import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/functions/localizations.dart';
//import 'package:vidflix/pages/login_signup/signup.dart';
//import 'package:vidflix/pages/login_signup/forgot_password.dart';
import 'package:vidflix/pages/home/home.dart';
import 'package:http/http.dart' as http;
//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String name, email, password1, password2;
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _password1Controller = new TextEditingController();
  TextEditingController _password2Controller = new TextEditingController();

  //BuildContext get context => context;
  //BuildContext get context => null;

  registerData(username, email, password1, password2) async {
    var url = "https://portal.mywau.com/dev/flutter/php/register.php";
    var response = await http.post(url, body: {
      "username": _usernameController.text.trim(),
      "email": _emailController.text.trim(),
      "password1": _password1Controller.text.trim(),
      "password2": _password2Controller.text.trim(),
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    if (jsonString == 'Success') {
      myToast(jsonString);
      nextpage();
      //saveSession(userid, name, phone_no);
      // Navigator.push(context,
      //     PageTransition(type: PageTransitionType.leftToRight, child: Login()));
    }
    // else if (jsonString == 'Email not found, please register') {
    //   myToast(jsonString);
    //   Navigator.push(
    //       context,
    //       PageTransition(
    //           type: PageTransitionType.rightToLeft, child: Signup()));
    // }
    else {
      myToast(jsonString);
    }
  }

  nextpage() {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.leftToRight, child: Login()));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //       image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover),
      // ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              child: new Image.network('https://i.imgur.com/faymREZh.png'),
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
              ),
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                        top: fixPadding * 2,
                        left: fixPadding * 2,
                        right: fixPadding * 2.0),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('signupPage', 'dontHaveAccountString'),
                      style: signupBigTextStyle,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: fixPadding * 2, right: fixPadding * 2.0),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('signupPage', 'createAccountString'),
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
                        controller: _usernameController,
                        style: headingStyle,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20.0, right: 20.0),
                          hintText: AppLocalizations.of(context)
                              .translate('signupPage', 'usernameString'),
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
                        controller: _emailController,
                        style: headingStyle,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20.0, right: 20.0),
                          hintText: AppLocalizations.of(context)
                              .translate('signupPage', 'emailString'),
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
                        controller: _password1Controller,
                        style: headingStyle,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20.0, right: 20.0),
                          hintText: AppLocalizations.of(context)
                              .translate('signupPage', 'passwordString'),
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
                        controller: _password2Controller,
                        style: headingStyle,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding:
                              EdgeInsets.only(left: 20.0, right: 20.0),
                          hintText: AppLocalizations.of(context)
                              .translate('signupPage', 'confirmPasswordString'),
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
                        registerData(
                            _usernameController.text,
                            _emailController.text,
                            _password1Controller.text,
                            _password2Controller.text);
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.rightToLeft,
                        //         child: Login()));
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
                              .translate('signupPage', 'createAccountString'),
                          style: headingStyle,
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
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: Home()));
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
                              'signupPage', 'alreadyHaveAccountString'),
                          style: headingStyle,
                        ),
                      ),
                    ),
                  ),
                  heightSpace,
                  heightSpace,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
