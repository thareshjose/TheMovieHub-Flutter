import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:themoviehub/components/constants.dart';
import 'package:themoviehub/components/horizontal_list.dart';
import 'package:themoviehub/components/movie_card.dart';
import 'package:themoviehub/services/movies.dart';

class HomeScreen extends StatefulWidget {
  static String id = 'home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('Movies'),
                  Text('TV Shows'),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            HorizontalList(
              category: 'trending',
              values: ['day', 'week'],
            ),
            SizedBox(
              height: 10.0,
            ),
            HorizontalList(
              category: 'popular',
              values: ['In Theaters', 'upcoming'],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(kLayoutBackgroundColor),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
        onTap: (index) {
          print('1');
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(
              'Home',
              style: kNavBarTextStyle,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text(
              'Search',
              style: kNavBarTextStyle,
            ),
          )
        ],
      ),
    );
  }
}
