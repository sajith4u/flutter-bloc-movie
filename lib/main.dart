import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movie_bloc/bloc/fetch_movie_event.dart';
import 'package:movie_bloc/bloc/fetch_movies_bloc.dart';
import 'package:movie_bloc/bloc/user_state.dart';
import 'package:movie_bloc/model/movie_item.dart';
import 'package:movie_bloc/provider/movie_http_client.dart';
import 'package:movie_bloc/repository/movie_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final MovieRepository movieRepository = MovieRepository(
      movieApiClient: MovieApiClient(httpClient: http.Client()),
    );
    return MaterialApp(
      title: 'Movie List Bloc',
      home: UsersPage(
        movieRepository: movieRepository,
      ),
    );
  }
}

class UsersPage extends StatefulWidget {
  final MovieRepository movieRepository;

  const UsersPage({Key key, this.movieRepository}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<UsersPage> {
  MovieBloc _movieBloc;

  @override
  void initState() {
    _movieBloc = MovieBloc(movieRepository: widget.movieRepository);
    _movieBloc.add(FetchMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Bloc App'),
      ),
      body: BlocBuilder<MovieBloc, MovieItemState>(
          bloc: _movieBloc,
          builder: (context, state) {
            if (state is MovieItemRequesting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MovieItemCompleted) {
              return _buildListView(state.movies);
            }
            if (state is MovieOnError) {
              return Center(
                child: Text('Oops Error Occurred'),
              );
            }
            return Container();
          }),
    );
  }

  ListView _buildListView(List<MovieItem> movies) {

    return ListView.builder(
      itemBuilder: (context, i) {
        return Container(height: 300, padding: EdgeInsets.only(left: 10, right: 10), child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Image.network(
            movies[i].banner.toString(),
            fit: BoxFit.fill,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),);
      },
      itemCount: movies.length,
    );
  }

  @override
  void dispose() {
    _movieBloc.close();
    super.dispose();
  }
}
