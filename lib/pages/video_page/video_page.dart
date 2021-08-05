import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/account/calendar.dart';
import 'package:vidflix/pages/account/kalendar.dart';
import 'package:vidflix/pages/category/more_list.dart';
import 'package:vidflix/pages/home/home_component/popular_movies.dart';
import 'package:vidflix/pages/video_page/episodes.dart';
import 'package:vidflix/pages/video_page/image_section.dart';
import 'package:vidflix/pages/video_page/title_description.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  SharedPreferences sharedPreferences;
  @override
  void initState() {
    super.initState();
    checkSession();
  }

  Future checkSession() async {
    SharedPreferences prefz = await SharedPreferences.getInstance();
    String user = prefz.getString('vidid');
    // Timer(
    //     Duration(seconds: 3),
    //     () => Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => user == null ? Calendar() : Kalendar()),
    //         ));
  }

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
              .translate('videoPage', 'webSeriesString'),
          style: headingStyle,
        ),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          ImageSection(),
          heightSpace,
          TitleDescription(),
          Padding(
            padding: EdgeInsets.all(fixPadding),
            child: Text(
              AppLocalizations.of(context)
                  .translate('videoPage', 'episodesString'),
              style: headingStyle,
            ),
          ),
          EpisodesList(),
          heightSpace,
          Padding(
            padding: EdgeInsets.all(fixPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)
                      .translate('videoPage', 'youMayAlsoLikeString'),
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
                          .translate('videoPage', 'moreString'),
                      style: linkStyle),
                ),
              ],
            ),
          ),
          PopularMoviesList(),
          heightSpace,
        ],
      ),
    );
  }
}
