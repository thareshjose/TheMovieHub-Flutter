import 'package:flutter/material.dart';

import 'cast_image_list.dart';
import 'constants.dart';

class Casts extends StatefulWidget {
  Casts({this.casts});
  List<dynamic> casts;

  @override
  _CastsState createState() => _CastsState();
}

class _CastsState extends State<Casts> {
  @override
  Widget build(BuildContext context) {
    int castsSize = widget.casts == null ? 0 : widget.casts.length;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: kLeftMargin,
      ),
      child: Column(
          crossAxisAlignment: castsSize == 0
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: castsSize == 0
              ? ([
                  kDivider,
                  Text(
                    'Cast Details Not Available!',
                    style: TextStyle(),
                  )
                ])
              : ([
                  kDivider,
                  Text(
                    'Casts',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(),
                  CastImageList(
                    cast: widget.casts,
                  ),
                  SizedBox(
                    height: 10.0,
                  )
                ])),
    );
  }
}
