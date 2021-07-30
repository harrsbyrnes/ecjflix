import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/video_page/video_page.dart';

class WatchLater extends StatefulWidget {
  @override
  _WatchLaterState createState() => _WatchLaterState();
}

class _WatchLaterState extends State<WatchLater> {
  int watchLatertItem = 4;

  final watchLaterItemList = [
    {'title': 'Pirates of the Caribbean', 'image': 'assets/slider/4.png'},
    {'title': 'Frozen II', 'image': 'assets/slider/3.png'},
    {'title': 'The Lion King', 'image': 'assets/slider/2.png'},
    {'title': 'Maleficent', 'image': 'assets/slider/1.png'}
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: blackColor,
      appBar: AppBar(
        backgroundColor: blackColor,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)
              .translate('watchLaterPage', 'watchLaterString'),
          style: headingStyle,
        ),
      ),
      body: (watchLatertItem == 0)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.heartBroken,
                    color: Colors.grey,
                    size: 60.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    AppLocalizations.of(context).translate(
                        'watchLaterPage', 'noItemInWatchLaterString'),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18.0,
                      fontFamily: 'Signika Negative',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: watchLaterItemList.length,
              itemBuilder: (context, index) {
                final item = watchLaterItemList[index];
                return Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.25,
                  secondaryActions: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: 5.0,
                        bottom: 5.0,
                      ),
                      child: IconSlideAction(
                        caption: AppLocalizations.of(context)
                            .translate('watchLaterPage', 'deleteString'),
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          setState(() {
                            watchLaterItemList.removeAt(index);
                            watchLatertItem = watchLatertItem - 1;
                          });

                          // Then show a snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                AppLocalizations.of(context).translate(
                                    'watchLaterPage', 'itemRemovedString'),
                                style: TextStyle(color: blackColor)),
                            backgroundColor: whiteColor,
                          ));
                        },
                      ),
                    ),
                  ],
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: VideoPage()));
                    },
                    child: Padding(
                      padding: EdgeInsets.all(fixPadding),
                      child: Container(
                        width: width - 30.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: DecorationImage(
                              image: AssetImage(item['image']),
                              fit: BoxFit.cover),
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: 0.0,
                              child: Container(
                                width: width - 30.0,
                                height: 40.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(20.0)),
                                  color: Colors.black.withOpacity(0.7),
                                ),
                                child: Text(
                                  item['title'],
                                  style: headingStyle,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
