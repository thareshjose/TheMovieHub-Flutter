import 'package:flutter/material.dart';
import 'package:themoviehub/components/movie_card.dart';
import 'package:themoviehub/services/network.dart';

const apiKey = '14a29c47d793fddf713896c543694bf3';
const trendingMoviesURL = 'https://api.themoviedb.org/3/trending/movie';
const trailerVideoURL = 'https://api.themoviedb.org/3/movie';
const movieDetailsURL = 'https://api.themoviedb.org/3/movie';
const seriesDetailsURL = 'https://api.themoviedb.org/3/tv';
const baseURL = 'https://api.themoviedb.org/3';

class Movies {
  Future<dynamic> getPopularMovies() async {
    NetworkHelper network = NetworkHelper(
        url:
            'https://api.themoviedb.org/3/trending/all/day?api_key=14a29c47d793fddf713896c543694bf3');
    var popularMoviesData = await network.getData();
    return popularMoviesData;
  }

  static Future<List> getMoviesList(
      String category, String type, int page) async {
    print('26');
    print(type);
    String url = category == 'trending'
        ? '$trendingMoviesURL/$type?api_key=$apiKey&page=$page'
        : type == 'upcoming'
            ? '$movieDetailsURL/$type?api_key=$apiKey&page=$page'
            : '$movieDetailsURL/now_playing?api_key=$apiKey&page=$page';
    NetworkHelper network = NetworkHelper(url: url);
    var result = await network.getData();
    List moviesList = result['results'];
    return moviesList;
  }

  static Future<dynamic> getTrailerVideo(String id, String mediaType) async {
    String videoId;
    NetworkHelper network = NetworkHelper(
        url: '${baseURL}/${mediaType}/${id}/videos?api_key=$apiKey');
    var result = await network.getData();
    List results = result['results'];
    if (results.length == 0) {
      videoId = "404";
    } else {
      videoId = result['results'][0]['key'];
    }
    return videoId;
  }

  static Future<dynamic> getAllDetails(String id, String mediaType) async {
    String detailsApiURL;

    if (mediaType == 'movie') {
      detailsApiURL = '$movieDetailsURL/$id?api_key=$apiKey';
    } else {
      detailsApiURL = '$seriesDetailsURL/$id?api_key=$apiKey';
    }
    NetworkHelper networkHelper = NetworkHelper(url: detailsApiURL);
    var result = await networkHelper.getData();
    return result;
  }

  static Future<dynamic> getCastDetails(String id, String mediaType) async {
    String castDetailsURL =
        '${baseURL}/${mediaType}/${id}/credits?api_key=${apiKey}';
    NetworkHelper networkHelper = NetworkHelper(url: castDetailsURL);
    var result = await networkHelper.getData();
    return result;
  }

//  static List getTrendingMovies(dynamic trendingMovies) {
//    List trendingMoviesList = [];
//    trendingMoviesList = trendingMovies['results'];
//    return trendingMoviesList;
//  }
}
