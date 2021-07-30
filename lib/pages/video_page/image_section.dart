import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/pages/video_play/video_play.dart';

class ImageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 440.0,
      width: width,
      child: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: 400.0,
            margin: EdgeInsets.only(
                top: 20.0, bottom: 30.0, right: 20.0, left: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage(
                    'assets/special_latest_movies/special_latest_movies_5.jpg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            right: ((width / 2) - 30.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(30.0),
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.scale,
                        alignment: Alignment.bottomCenter,
                        child: VideoPlay()));
              },
              child: Container(
                width: 60.0,
                height: 60.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  color: Colors.red,
                ),
                child: Icon(Icons.play_arrow, color: whiteColor, size: 30.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
