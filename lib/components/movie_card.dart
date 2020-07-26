import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:themoviehub/components/constants.dart';
import 'package:themoviehub/screens/movie_details.dart';

class MovieCard extends StatelessWidget {
  MovieCard({
    Key key,
    @required this.movie,
  }) : super(key: key);
  var movie;
  String poster;
  double averageVote;
  int trendPercentage;
  double percentage;

  @override
  Widget build(BuildContext context) {
    poster = movie['poster_path'];
    averageVote = movie['vote_average'].toDouble();
    trendPercentage = averageVote.toInt() * 10;
    percentage = trendPercentage / 100;

    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            print(movie['title']);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetails(movie: movie),
              ),
            );
          },
          child: Card(
            shadowColor: Colors.black87,
            margin: EdgeInsets.only(
              right: 12.0,
            ),
            child: Image.network(
              'https://image.tmdb.org/t/p/w300$poster',
              height: kMovieCardHeight,
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
        Positioned(
          top: 160,
          left: 10.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                30.0,
              ),
            ),
            clipBehavior: Clip.antiAlias,
            child: CircularPercentIndicator(
              fillColor: Colors.black,
              radius: 30.0,
              lineWidth: 3.0,
              percent: percentage,
              center: RichText(
                text: TextSpan(
                    text: "$trendPercentage",
                    style: TextStyle(
                      fontSize: 12.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '%',
                        style: TextStyle(
                          fontSize: 8.0,
                        ),
                      ),
                    ]),
              ),
              progressColor: trendPercentage > 70.0
                  ? Colors.green
                  : trendPercentage > 30.0 ? Color(0xFFEDAD00) : Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
