import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/pages/video_play/video_play.dart';

class EpisodesList extends StatefulWidget {
  @override
  _EpisodesListState createState() => _EpisodesListState();
}

class _EpisodesListState extends State<EpisodesList> {
  final moviesList = [
    {
      'image': 'assets/episode/episode_1.jpg',
      'title': 'S1 - E1',
    },
    {
      'image': 'assets/episode/episode_2.jpg',
      'title': 'S1 - E2',
    },
    {
      'image': 'assets/episode/episode_3.jpg',
      'title': 'S1 - E3',
    },
    {
      'image': 'assets/episode/episode_4.jpg',
      'title': 'S1 - E4',
    }
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 150.0,
      child: ListView.builder(
        itemCount: moviesList.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = moviesList[index];
          return InkWell(
            onTap: () {
              Navigator.push(context, PageTransition(type: PageTransitionType.scale, alignment: Alignment.bottomCenter, child: VideoPlay()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 170.0,
                  height: 120.0,
                  margin: EdgeInsets.only(
                    left: 10.0,
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(item['image']),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 17.0),
                  child: Text(item['title'], style: descriptionStyle,),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
