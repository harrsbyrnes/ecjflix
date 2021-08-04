import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/video_page/video_page.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int calendartItem = 10;

  final calendarItemList = [
    {
      'title': 'New Years Day',
      'date': '1 January',
      'image': 'assets/slider/nyd.jpeg'
    },
    {
      'title': 'Thaipusam',
      'date': '28 January',
      'image': 'assets/slider/thaipusam.jpeg'
    },
    // {
    //   'title': 'Chinese New Year',
    //   'date': '11-13 February',
    //   'image': 'assets/slider/cny.jpeg'
    // },
    {
      'title': 'National Day',
      'date': '31 August',
      'image': 'assets/slider/nd.jpeg'
    },
    {
      'title': 'Awal Muharram',
      'date': '10 August',
      'image': 'assets/slider/awal.jpeg'
    },
    {
      'title': 'Nuzul Alquran',
      'date': '29 April',
      'image': 'assets/slider/nuzul.jpeg'
    },
    {
      'title': 'Hari Raya Puasa',
      'date': '13-14 May',
      'image': 'assets/slider/hrp.jpeg'
    },
    {
      'title': 'Deepavali',
      'date': '10 October',
      'image': 'assets/slider/deepavali.jpeg'
    },
    {
      'title': 'Malaysia Day',
      'date': '16 September',
      'image': 'assets/slider/malaysiaday.jpeg'
    },
    {
      'title': 'Christmas Day',
      'date': '25 December',
      'image': 'assets/slider/christmas.jpeg'
    }
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
          'Calendar Cuti Bursa Malaysia',
          // AppLocalizations.of(context)
          //     .translate('watchLaterPage', 'watchLaterString'),
          style: headingStyle,
        ),
      ),
      body: (calendartItem == 0)
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
              itemCount: calendarItemList.length,
              itemBuilder: (context, index) {
                final item = calendarItemList[index];
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
                            calendarItemList.removeAt(index);
                            calendartItem = calendartItem - 1;
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
                        height: 90.0,
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
                                height: 25.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(
                                      bottom: Radius.circular(20.0)),
                                  color: Colors.brown[900].withOpacity(0.7),
                                ),
                                child: Text(
                                  item['date'],
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
