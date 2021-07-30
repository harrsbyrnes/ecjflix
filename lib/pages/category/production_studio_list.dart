import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:vidflix/pages/category/more_list.dart';

class ProductionStudioList extends StatefulWidget {
  @override
  _ProductionStudioListState createState() => _ProductionStudioListState();
}

class _ProductionStudioListState extends State<ProductionStudioList> {
  final studioList = [
    {
      'image': 'assets/production_studio/studio_1.png',
    },
    {
      'image': 'assets/production_studio/studio_2.png',
    },
    {
      'image': 'assets/production_studio/studio_3.png',
    },
    {
      'image': 'assets/production_studio/studio_4.png',
    },
    {
      'image': 'assets/production_studio/studio_5.png',
    }
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 100.0,
      child: ListView.builder(
        itemCount: studioList.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final item = studioList[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.bottomToTop, child: MoreList()));
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
