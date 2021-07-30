import 'package:flutter/material.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:chewie/chewie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';

class EditProfile extends StatefulWidget {
  final ChewieController chewieController;
  EditProfile({Key key, this.chewieController}) : super(key: key);
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  String oldpassword, newpassword1, newpassword2;
  String phone = '0185665421';
  String address = 'Idaman Puri';
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController oldpasswordController = new TextEditingController();
  TextEditingController newpassword1Controller = new TextEditingController();
  TextEditingController newpassword2Controller = new TextEditingController();

  bool editMode = false;

  Future getData() async {
    var url = 'https://portal.mywau.com/dev/flutter/php/read.php';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  updatePhone(phone) async {
    var url = "https://portal.mywau.com/dev/flutter/php/updatephone.php";
    var response = await http.post(url, body: {
      "phone": phoneController.text.trim(),
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    if (jsonString == 'Success') {
      myToast(jsonString);
    } else {
      myToast(jsonString);
    }
  }

  updateAddress(address) async {
    var url = "https://portal.mywau.com/dev/flutter/php/updateaddress.php";
    var response = await http.post(url, body: {
      "address": addressController.text.trim(),
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    if (jsonString == 'Success') {
    } else {
      myToast(jsonString);
    }
  }

  changeNewPassword(oldpassword, newpassword1, newpassword2) async {
    var url = "https://portal.mywau.com/dev/flutter/php/changePassword.php";
    var response = await http.post(url, body: {
      "one": oldpasswordController.text.trim(),
      "two": newpassword1Controller.text.trim(),
      "three": newpassword2Controller.text.trim(),
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    if (jsonString == 'Success') {
      myToast(jsonString);
    } else {
      myToast(jsonString);
    }
  }

  changeImage(int index) async {
    var url = "https://portal.mywau.com/dev/flutter/php/update_image.php";
    var response = await http.post(url, body: {
      "index": index.toString(),
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    myToast(jsonString);
  }

  final imageList = [
    {
      'image': 'https://i.imgur.com/E6yPdOs.png',
    },
    {
      'image': 'https://i.imgur.com/vcsBf16.png',
    },
    {
      'image': 'https://i.imgur.com/bvhhR9e.png',
    },
    {
      'image': 'https://i.imgur.com/CoPBN2O.png',
    },
    {
      'image': 'https://i.imgur.com/5yRWi7G.png',
    },
    {
      'image': 'https://i.imgur.com/Om4llaP.png',
    },
    {
      'image': 'https://i.imgur.com/8Hujg2M.png',
    },
    {
      'image': 'https://i.imgur.com/jDy2JPT.png',
    },
    {
      'image': 'https://i.imgur.com/sXqyPv0.png',
    },
    {
      'image': 'https://i.imgur.com/9Nosa6o.png',
    }
  ];

  @override
  void initState() {
    super.initState();
    phoneController.text = phone;
    addressController.text = address;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    changePhoneNumber() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          // return object of type Dialog
          return Dialog(
              elevation: 0.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: FutureBuilder(
                  future: getData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return snapshot.hasData
                        ? Container(
                            height: 210.0,
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  AppLocalizations.of(context).translate(
                                      'editProfilePage',
                                      'changePhoneNumberString'),
                                  style: TextStyle(
                                    fontFamily: 'Mukta',
                                    fontSize: 21.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                TextField(
                                  controller: phoneController,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Mukta',
                                  ),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: AppLocalizations.of(context)
                                        .translate('editProfilePage',
                                            'enterPhoneNumberString'),
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Mukta',
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
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
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('editProfilePage',
                                                  'cancelString'),
                                          style: TextStyle(
                                            fontFamily: 'Mukta',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          // address = addressController.text;
                                          updatePhone(phoneController.text);
                                          Navigator.pop(context);
                                        });
                                        // setState(() {
                                        //   phone = phoneController.text;
                                        //   Navigator.pop(context);
                                        // });
                                        // Navigator.push(
                                        //     context,
                                        //     PageTransition(
                                        //         type: PageTransitionType
                                        //             .rightToLeft,
                                        //         child: EditProfile()));
                                      },
                                      child: Container(
                                        width: (width / 3.5),
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: redColor,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .translate('editProfilePage',
                                                  'okayString'),
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
                          )
                        : CircularProgressIndicator();
                  }));
        },
      );
    }

    changePassword() {
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
              height: 305.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).translate(
                        'editProfilePage', 'changeYourPasswordString'),
                    style: TextStyle(
                      fontFamily: 'Mukta',
                      fontSize: 21.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextField(
                    controller: oldpasswordController,
                    obscureText: true,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Mukta',
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .translate('editProfilePage', 'oldPasswordString'),
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Mukta',
                      ),
                    ),
                  ),
                  TextField(
                    controller: newpassword1Controller,
                    obscureText: true,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Mukta',
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).translate(
                          'editProfilePage', 'confirmNewPasswordString'),
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Mukta',
                      ),
                    ),
                  ),
                  TextField(
                    controller: newpassword2Controller,
                    obscureText: true,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Mukta',
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).translate(
                          'editProfilePage', 'confirmNewPasswordString'),
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Mukta',
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
                                .translate('editProfilePage', 'cancelString'),
                            style: TextStyle(
                              fontFamily: 'Mukta',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            // address = addressController.text;
                            changeNewPassword(
                                oldpasswordController.text,
                                newpassword1Controller.text,
                                newpassword2Controller.text);
                            Navigator.pop(context);
                          });

                          //Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     PageTransition(
                          //         type: PageTransitionType.rightToLeft,
                          //         child: EditProfile()));
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
                                .translate('editProfilePage', 'okayString'),
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
          );
        },
      );
    }

    changeEmail() {
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
              height: 200.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)
                        .translate('editProfilePage', 'changeEmailString'),
                    style: TextStyle(
                      fontFamily: 'Mukta',
                      fontSize: 21.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextField(
                    controller: addressController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Mukta',
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)
                          .translate('editProfilePage', 'enterEmailString'),
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Mukta',
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
                                .translate('editProfilePage', 'cancelString'),
                            style: TextStyle(
                              fontFamily: 'Mukta',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          //updateAddress(addressController.text);
                          setState(() {
                            // address = addressController.text;
                            updateAddress(addressController.text);
                            Navigator.pop(context);
                          });
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
                                .translate('editProfilePage', 'okayString'),
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
          );
        },
      );
    }

    showUploadImageActionSheet() {
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
              height: 300.0,
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    ('Change Profile Image'),
                    style: TextStyle(
                      fontFamily: 'Mukta',
                      fontSize: 21.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                      width: width,
                      height: 130.0,
                      padding: EdgeInsets.only(top: 20.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemCount: imageList == null ? 0 : imageList.length,
                        itemBuilder: (context, index) {
                          final item = imageList[index];
                          return InkWell(
                            onTap: () {
                              if (widget.chewieController != null) {
                                widget.chewieController.pause();
                              }
                              setState(() {
                                changeImage(index);
                                Navigator.pop(context);
                              });
                            },
                            child: Container(
                              width: 100.0,
                              margin: EdgeInsets.only(
                                left: 10.0,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(item['image']),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          );
                        },
                      )),
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
                                .translate('editProfilePage', 'cancelString'),
                            style: TextStyle(
                              fontFamily: 'Mukta',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.pop(context);
                          });
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
                                .translate('editProfilePage', 'okayString'),
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
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        centerTitle: true,
        title: Text(
            AppLocalizations.of(context)
                .translate('editProfilePage', 'editProfileString'),
            style: headingStyle),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      SizedBox(height: 15.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              // image: DecorationImage(
                              //   image: AssetImage('assets/user_profile/' +
                              //       snapshot.data[6]["lastname"].toString()),
                              //   fit: BoxFit.cover,
                              // ),
                              image: DecorationImage(
                                image: NetworkImage(snapshot.data[2]["image"]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                showUploadImageActionSheet();
                              },
                              child: Container(
                                height: 100.0,
                                width: 100.0,
                                color: Colors.black.withOpacity(0.5),
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: whiteColor,
                                  size: 25.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            snapshot.data[2]["lastname"].toString(),
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Mukta',
                              fontWeight: FontWeight.w500,
                              color: whiteColor,
                            ),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            width: width - 30.0,
                            margin: EdgeInsets.only(right: 20.0, left: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                heightSpace,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('editProfilePage',
                                                  'phoneNumberString'),
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Mukta',
                                            fontWeight: FontWeight.w500,
                                            color: whiteColor,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        // snapshot.data['firstname'].toString() ==
                                        //         '$number'
                                        //     ?

                                        Text(
                                          snapshot.data[2]["phone"].toString(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: 'Mukta',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                        )
                                        // : Text('error')
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        changePhoneNumber();
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey[400],
                                        size: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('editProfilePage',
                                                  'addressString'),
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Mukta',
                                            fontWeight: FontWeight.w500,
                                            color: whiteColor,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          snapshot.data[2]["address"]
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: 'Mukta',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        changeEmail();
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey[400],
                                        size: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)
                                              .translate('editProfilePage',
                                                  'passwordString'),
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            fontFamily: 'Mukta',
                                            fontWeight: FontWeight.w500,
                                            color: whiteColor,
                                          ),
                                        ),
                                        SizedBox(height: 5.0),
                                        Text(
                                          '*****',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontFamily: 'Mukta',
                                            fontWeight: FontWeight.w500,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        changePassword();
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey[400],
                                        size: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : CircularProgressIndicator();
          }),
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
