import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class CastImageList extends StatelessWidget {
  CastImageList({this.cast});

  List<dynamic> cast;
  @override
  Widget build(BuildContext context) {
    print(' ');
    print(' ');
    print(cast);
    print('cast above');
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(right: 10.0),
            width: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          'https://image.tmdb.org/t/p/w300/${cast[index]['profile_path']}',
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        cast[index]['name'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                        ),
                      ),
                      Text(
                        'as',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        cast[index]['character'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width / 43,
                          color: Colors.grey.shade200,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: cast == null ? 0 : (cast.length > 10 ? 10 : cast.length),
      ),
      height: 190.0,
    );
  }
}
