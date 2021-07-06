import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:movie_bloc/model/movie_item.dart';

abstract class MovieItemState extends Equatable {

  MovieItemState([List props = const []]);

  @override
  List<Object> get props => [];
}

class MovieItemRequesting extends MovieItemState {}

class MovieItemLoading extends MovieItemState {}

class MovieItemCompleted extends MovieItemState {
  final List<MovieItem> movies;

  MovieItemCompleted({@required this.movies})
      : assert(movies != null),
        super([movies]);
}

class MovieOnError extends MovieItemState {}