import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/pages/video_page/video_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PopularMoviesList extends StatefulWidget {
  final ChewieController chewieController;

  PopularMoviesList({Key key, this.chewieController}) : super(key: key);
  @override
  _PopularMoviesListState createState() => _PopularMoviesListState();
}

class _PopularMoviesListState extends State<PopularMoviesList> {
  Future getData() async {
    var url = 'https://portal.mywau.com/dev/flutter/php/popular_movies.php';
    var response = await http.get(url);

    // List<dynamic> data1 = json.decode(response.body);
    // print(response);
    //return json.decode(response.body);
    var jsonData = jsonDecode(response.body);
    var image = jsonData['image'];
    return image;
  }

  final moviesList = [
    {
      'image': 'assets/popular_movies/popular_movies_1.jpg',
    },
    {
      'image': 'assets/popular_movies/popular_movies_2.jpg',
    },
    {
      'image': 'assets/popular_movies/popular_movies_3.jpg',
    },
    {
      'image': 'assets/popular_movies/popular_movies_4.jpg',
    },
    {
      'image': 'assets/popular_movies/popular_movies_5.jpg',
    },
    {
      'image': 'assets/popular_movies/popular_movies_6.jpg',
    }
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 130.0,
      child: ListView.builder(
        itemCount: moviesList.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = moviesList[index];
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
                  image: AssetImage(item['image']),
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
