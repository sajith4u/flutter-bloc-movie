import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movie_bloc/bloc/fetch_movie_event.dart';
import 'package:movie_bloc/bloc/user_state.dart';
import 'package:movie_bloc/model/movie_item.dart';
import 'package:movie_bloc/repository/movie_repository.dart';

class MovieBloc extends Bloc<MovieFetchEvent, MovieItemState> {
  final MovieRepository movieRepository;

  MovieBloc({@required this.movieRepository}) : assert(movieRepository != null), super(null);

  @override
  MovieItemState get iniState => MovieItemRequesting();

  @override
  Stream<MovieItemState> mapEventToState(MovieFetchEvent event) async* {
    if (event is FetchMovies) {
      yield MovieItemLoading();
      try {
        final List<MovieItem> movies = await movieRepository.fetchAllMovies();
        yield MovieItemCompleted(movies: movies);
      } catch (e) {
        print(e);
        yield MovieOnError();
      }
    }
  }
}