import 'dart:async';

import 'package:meta/meta.dart';
import 'package:movie_bloc/model/movie_item.dart';
import 'package:movie_bloc/provider/movie_http_client.dart';

class MovieRepository {
  final MovieApiClient movieApiClient;

  MovieRepository({@required this.movieApiClient})
      : assert(movieApiClient != null);

  Future<List<MovieItem>> fetchAllMovies() async {
    return await movieApiClient.fetchMovieItems();
  }
}
