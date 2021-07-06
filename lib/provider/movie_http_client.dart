import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movie_bloc/model/movie_item.dart';

class MovieApiClient {
  final _baseUrl = 'https://movie-booking-api.herokuapp.com/movies/all';
  final http.Client httpClient;

  MovieApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<List<MovieItem>> fetchMovieItems() async {
    final List<MovieItem> allMovies = [];
    http.Response response = await httpClient.get(_baseUrl);
    List<dynamic> responseData = jsonDecode(response.body);
    responseData.forEach((singleUser) {
      allMovies.add(MovieItem.fromJson(singleUser));
    });
    return allMovies;
  }
}