import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:video_player/video_player.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/category/more_list.dart';
import 'package:vidflix/pages/home/home_component/popular_movies.dart';
import 'package:vidflix/pages/video_play/more_episodes.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class VideoPlay extends StatefulWidget {
  @override
  _VideoPlayState createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  ChewieController _chewieController;
  YoutubePlayerController _controller;
  // PlayerState _playerState;
  // YoutubeMetaData _videoMetaData;
  // bool _isPlayerReady = false;
  // final videoPlayerController =
  //     VideoPlayerController.network('https://youtu.be/sE5WfxyUJTc.mp4');
  // final YoutubePlayerController = YoutubePlayerController(
  //   initialVideoId : YoutubePlayerController.convertUrlToId(url),
  //   flags : YoutubePlayerFlags(
  //     autoPlay: false,
  //     mute: false,
  //     disableDragSeek: false,
  //     loop: false,
  //     isLive: false,
  //     forceHD: false,
  //   ),
  // );

  Future getData() async {
    var url = 'https://portal.mywau.com/dev/flutter/php/read.php';
    var response = await http.get(url);
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    // _chewieController = ChewieController(
    //   videoPlayerController: videoPlayerController,
    //   aspectRatio: 16 / 9,
    //   autoInitialize: true,
    //   autoPlay: true,
    //   looping: true,
    //   errorBuilder: (context, errorMessage) {
    //     return Center(
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Text(
    //           errorMessage,
    //           style: TextStyle(
    //             color: Colors.white,
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
    var url = 'https://www.youtube.com/watch?v=V89BOZhJFlI&ab_channel=BleylDev';
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: true,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    ); //..addListener(listener);
    // _idController = TextEditingController();
    // _seekToController = TextEditingController();
    // _videoMetaData = const YoutubeMetaData();
    // _playerState = PlayerState.unknown;
  }

  // void listener() {
  //   if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //     setState(() {
  //       _playerState = _controller.value.playerState;
  //       _videoMetaData = _controller.metadata;
  //     });
  //   }
  // }

  // @override
  // void deactivate() {
  //   super.deactivate();
  //   _controller.pause();
  //   _chewieController.pause();
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _chewieController.pause();
  //   _controller.pause();
  //   _controller.dispose();
  //   _chewieController.dispose();
  // }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
          aspectRatio: 16 / 9,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.blueAccent,
        ),
        builder: (context, player) {
          return Scaffold(
            backgroundColor: blackColor,
            appBar: AppBar(
              backgroundColor: blackColor,
              elevation: 0.0,
              centerTitle: true,
              title: Text(
                'Criminal Justice',
                style: headingStyle,
              ),
            ),
            body: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                player,
                heightSpace,
                Padding(
                  padding: EdgeInsets.only(left: fixPadding),
                  child: Text(
                    'Criminal Justice',
                    style: headingStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: fixPadding, left: fixPadding),
                  child: Text(
                    'S1 - E1',
                    style: descriptionStyle,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(fixPadding),
                  child: Text(
                    AppLocalizations.of(context)
                        .translate('videoPlayPage', 'moreEpisodesString'),
                    style: headingStyle,
                  ),
                ),
                MoreEpisodesList(chewieController: _chewieController),
                heightSpace,
                Padding(
                  padding: EdgeInsets.all(fixPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)
                            .translate('videoPlayPage', 'youMayAlsoLikeString'),
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
                                .translate('videoPlayPage', 'moreString'),
                            style: linkStyle),
                      ),
                    ],
                  ),
                ),
                PopularMoviesList(chewieController: _chewieController),
                heightSpace,
              ],
            ),
          );
        });
  }
}
