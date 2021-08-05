import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/pages/video_page/video_page.dart';
import 'package:chewie/chewie.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SpecialLatestMoviesList extends StatefulWidget {
  final ChewieController chewieController;

  SpecialLatestMoviesList({Key key, this.chewieController}) : super(key: key);
  @override
  _SpecialLatestMoviesListState createState() =>
      _SpecialLatestMoviesListState();
}

class _SpecialLatestMoviesListState extends State<SpecialLatestMoviesList> {
  List datad;

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  Future<String> getData() async {
    http.Response response = await http.get(
        Uri.parse(
            "https://portal.mywau.com/dev/flutter/php/popular_movies2.php"),
        headers: {"Accept": "application/json"});

    setState(() {
      datad = json.decode(response.body);
    });
    return "Success!";
  }

  videoIndex(int index) async {
    // var url = "https://portal.mywau.com/dev/flutter/php/videoIndex.php";
    var url = "https://portal.mywau.com/dev/flutter/php/logina.php";
    var response = await http.post(url, body: {
      "index": index.toString(),
      // "email": email.text.trim(),
      // "password": password.text.trim(),
    });
    var jsonData = jsonDecode(response.body);
    var jsonString = jsonData['message'];
    var vidid = jsonData['id'];
    var vidname = jsonData['name'];
    if (jsonString == 'Success') {
      myToast(jsonString);
      saveSession(vidid, vidname);
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.rightToLeft, child: VideoPage()));
    } else {
      myToast(jsonString);
    }
  }

  saveSession(vidid, vidname) async {
    SharedPreferences prefz = await SharedPreferences.getInstance();

    //prefz.setString('id', vidid.trim());
    prefz.setString('vidid', vidid.toString().trim());
    prefz.setString('vidname', vidname.toString().trim());
  }

  @override
  void initState() {
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 130.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemCount: datad == null ? 0 : datad.length,
        itemBuilder: (context, index) {
          //final item = moviesList[index];
          final item = datad[index];
          return InkWell(
            onTap: () {
              if (widget.chewieController != null) {
                widget.chewieController.pause();
              }
              videoIndex(index);
              // Navigator.push(
              //     context,
              //     PageTransition(
              //         type: PageTransitionType.fade, child: VideoPage()));
            },
            child: Container(
              width: 100.0,
              margin: EdgeInsets.only(
                left: 10.0,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(item['image_url']),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          );
        },
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
