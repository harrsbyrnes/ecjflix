import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/animation/fadeUp.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/video_page/video_page.dart';

class MoreList extends StatefulWidget {
  @override
  _MoreListState createState() => _MoreListState();
}

class _MoreListState extends State<MoreList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)
              .translate('moreListPage', 'multiplexMoviesString'),
          style: headingStyle,
        ),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 10 / 12,
        children: <Widget>[
          gridItem('assets/special_latest_movies/special_latest_movies_1.jpg'),
          gridItem('assets/special_latest_movies/special_latest_movies_2.jpg'),
          gridItem('assets/special_latest_movies/special_latest_movies_3.jpg'),
          gridItem('assets/special_latest_movies/special_latest_movies_4.jpg'),
          gridItem('assets/special_latest_movies/special_latest_movies_5.jpg'),
          gridItem('assets/special_latest_movies/special_latest_movies_6.jpg'),
          gridItem('assets/popular_movies/popular_movies_1.jpg'),
          gridItem('assets/popular_movies/popular_movies_2.jpg'),
          gridItem('assets/popular_movies/popular_movies_3.jpg'),
        ],
      ),
    );
  }

  gridItem(String imagePath) {
    return FadeUp(
      0.6,
      InkWell(
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: VideoPage()));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
