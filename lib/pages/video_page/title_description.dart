import 'package:flutter/material.dart';
import 'package:vidflix/constant/constant.dart';

class TitleDescription extends StatefulWidget {
  @override
  _TitleDescriptionState createState() => _TitleDescriptionState();
}

class _TitleDescriptionState extends State<TitleDescription> {
  bool favourite = false;

  @override
  Widget build(BuildContext context) {
    _setFavourite() {
      setState(() {
        favourite = !favourite;
      });
      final snackBar = SnackBar(
        content: (favourite)
            ? Text('Added to Watch Later', style: TextStyle(color: blackColor))
            : Text('Remove from Watch Later',
                style: TextStyle(color: blackColor)),
        backgroundColor: whiteColor,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    return Padding(
      padding: EdgeInsets.all(fixPadding),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Criminal Justice',
                style: headingStyle,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.file_download,
                      color: whiteColor,
                      size: 35.0,
                    ),
                  ),
                  SizedBox(width: 15.0),
                  InkWell(
                    onTap: _setFavourite,
                    child: Icon(
                      (favourite) ? Icons.favorite : Icons.favorite_border,
                      color: whiteColor,
                      size: 35.0,
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Container(
                    height: 44.0,
                    width: 44.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      border: Border.all(width: 1.0, color: whiteColor),
                    ),
                    child: Container(
                      height: 38.0,
                      width: 38.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19.0),
                        color: whiteColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '4.5',
                            style: TextStyle(
                              fontSize: 14.5,
                              fontFamily: 'Mukta',
                              fontWeight: FontWeight.w300,
                              color: blackColor,
                            ),
                          ),
                          SizedBox(
                            width: 2.0,
                          ),
                          Icon(
                            Icons.star,
                            color: blackColor,
                            size: 14.5,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          heightSpace,
          Text(
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
            style: descriptionStyle,
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }
}
