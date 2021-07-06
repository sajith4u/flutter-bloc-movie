import 'package:equatable/equatable.dart';

class MovieItem extends Equatable {
  final String id;
  final String name;
  final String banner;
  final String director;

  const MovieItem({this.id, this.name, this.banner, this.director});

  @override
  List<Object> get props => [id, name, director];

  static MovieItem fromJson(dynamic json) {
    return MovieItem(
        id: json['id'].toString(),
        name: json['name'].toString(),
        banner: json['banner'].toString(),
        director: json['director'].toString());
  }
}
