import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/constant/constant.dart';
import 'package:vidflix/functions/localizations.dart';
import 'package:vidflix/pages/video_page/video_page.dart';

class Kalendar extends StatefulWidget {
  @override
  _KalendarState createState() => _KalendarState();
}

class _KalendarState extends State<Kalendar> {
  int kalendartItem = 4;

  final kalendarItemList = [
    {'title': 'New Years Day', 'image': 'assets/slider/5.jpeg'},
    {'title': 'Chinese New Years Eve', 'image': 'assets/slider/5.jpeg'},
    {'title': 'Wesak Day', 'image': 'assets/slider/5.jpeg'},
    {'title': 'National Day', 'image': 'assets/slider/5.jpeg'},
    {'title': 'Awal Muharram', 'image': 'assets/slider/5.jpeg'},
    {'title': 'Nuzul Alquran', 'image': 'assets/slider/5.jpeg'},
    {'title': 'Hari Raya Puasa', 'image': 'assets/slider/5.jpeg'},
    {'title': 'Thaipusam', 'image': 'assets/slider/5.jpeg'},
    {'title': 'Malaysia Day', 'image': 'assets/slider/5.jpeg'},
    {'title': 'Christmas Day', 'image': 'assets/slider/5.jpeg'}
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
      body: (kalendartItem == 0)
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
          : Table(
              border: TableBorder.all(),
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: FlexColumnWidth(),
                2: FixedColumnWidth(64),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    Container(
                      height: 32,
                      color: Colors.red,
                    ),
                    TableCell(
                      verticalAlignment: TableCellVerticalAlignment.top,
                      child: Container(
                        height: 32,
                        width: 32,
                        color: Colors.red,
                        child: Text(
                          'Calendar Cuti Bursa Malaysia',
                          style: headingStyle,
                        ),
                      ),
                    ),
                    Container(
                      height: 64,
                      color: Colors.red,
                    ),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                  ),
                  children: <Widget>[
                    Container(
                      height: 64,
                      width: 128,
                      color: Colors.red,
                    ),
                    Container(
                      height: 32,
                      color: Colors.red,
                    ),
                    Center(
                      child: Container(
                        height: 32,
                        width: 32,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
