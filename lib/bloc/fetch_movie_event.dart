import 'package:equatable/equatable.dart';

abstract class MovieFetchEvent extends Equatable {
  const MovieFetchEvent();
}

class FetchMovies extends MovieFetchEvent {
  const FetchMovies();

  @override
  List<Object> get props => [];
}