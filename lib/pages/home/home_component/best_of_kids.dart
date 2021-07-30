import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/pages/video_page/video_page.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:chewie/chewie.dart';

class BestOfKidsList extends StatefulWidget {
  final ChewieController chewieController;

  BestOfKidsList({Key key, this.chewieController}) : super(key: key);
  @override
  _BestOfKidsListState createState() => _BestOfKidsListState();
}

class _BestOfKidsListState extends State<BestOfKidsList> {
  List datad;

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
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: VideoPage()));
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
}
