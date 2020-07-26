import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:themoviehub/components/cast_image_list.dart';
import 'package:themoviehub/components/casts.dart';
import 'package:themoviehub/components/constants.dart';
import 'package:themoviehub/components/list_loading_animation.dart';
import 'package:themoviehub/components/trailer_video.dart';
import 'package:themoviehub/services/movies.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails({this.movie});
  var movie;
  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  var movie;
  Map<String, dynamic> media;
  String title;
  String movieId;
  String videoId;
  String mediaType;
  final String backdropURL = 'https://image.tmdb.org/t/p/original';
  String backdropPath;
  bool loading = true;
  String posterPath;
  String releaseDate;
  int trendPercentage;
  String genres = "";
  List<dynamic> casts;

  @override
  void initState() {
    getAllDetails();
    super.initState();
  }

  void getAllDetails() async {
    mediaType = widget.movie['media_type'];
    mediaType = mediaType == null ? 'movie' : mediaType;
    movieId = widget.movie['id'].toString();
    media = await Movies.getAllDetails(
      movieId,
      mediaType,
    );
    title = media['title'] != null ? media['title'] : media['name'];
    backdropPath = media['backdrop_path'];
    posterPath = media['poster_path'];
    String date =
        mediaType == "movie" ? media['release_date'] : media['first_air_date'];
    releaseDate = getReleaseDate(date);
    trendPercentage = media['vote_average'].toInt() * 10;
    if (media.containsKey('genres')) {
      getGenres();
    }
    getCastDetails();
    getVideoId();
  }

  void getGenres() {
    List<dynamic> genresList = media['genres'];
    for (var genre in genresList) {
      genres += genre['name'];
      genres += ', ';
    }
    genres = genres.substring(0, genres.length - 2);
    print(genres);
  }

  void getCastDetails() async {
    var castDetails = await Movies.getCastDetails(movieId, mediaType);
    print(castDetails);
    setState(() {
      casts = castDetails['cast'];
    });
    print('cases h');
  }

  void getVideoId() async {
    videoId = await Movies.getTrailerVideo(movieId, mediaType);
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  String getReleaseDate(date) {
    List<String> dateList = date.split("-");
    return DateFormat.yMMMMEEEEd()
        .format(DateTime(int.parse(dateList[0]), int.parse(dateList[1]),
            int.parse(dateList[2])))
        .split(",")
        .sublist(1)
        .toString()
        .replaceAll(new RegExp(r'[\[\]]'), "");
  }

  @override
  Widget build(BuildContext context) {
    print(media);
    return Scaffold(
      appBar: AppBar(),
      body: loading == true
          ? ListLoadingAnimation()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: <Widget>[
                      Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Image.network(
                            '$backdropURL/$backdropPath',
//                            height: 500,
                          ),
                          Positioned(
                            top: 110,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.5),
                                      blurRadius: 30.0,
                                      spreadRadius: 20.0,
                                      offset: Offset(0, 25),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      title,
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Image.network(
                                          'https://image.tmdb.org/t/p/w300$posterPath',
                                          height: 160.0,
                                          fit: BoxFit.contain,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6,
                                            padding:
                                                EdgeInsets.only(left: 10.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  'Release: ${releaseDate}',
                                                  //TODO: Fix date issue for tv series
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text(
                                                    'Runtime: ${media['runtime']} mins'),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Icon(
                                                      FontAwesomeIcons.gripfire,
                                                      color: Colors.orange,
                                                      size: 30.0,
                                                    ),
                                                    Text(
                                                      '${trendPercentage}',
                                                      style: kPopularityStyle,
                                                    ),
                                                    Text('%')
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.0,
                                                ),
                                                Text(
                                                  genres,
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
//                      TrailerPlayer(
//                        videoId: videoId,
//                      ),
                      SizedBox(
                        height: 90,
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 10.0, right: 10.0, bottom: 10.0),
                        child: Text(
                          media['overview'],
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.4,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: kLeftMargin),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            kDivider,
                            Text('Watch on:'),
                          ],
                        ),
                      ),
                      Casts(
                        casts: casts,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: kLeftMargin),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            kDivider,
                            Text(
                              'Trailer',
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                            TrailerPlayer(
                              videoId: videoId,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
