import 'genre_model.dart';

class DetailsModel {
  String posterPath;
  String releaseDate;
  List<GenreModel> genres;
  int id;
  String title;
  String backdropPath;
  String overview;

  DetailsModel({
    this.posterPath,
    this.releaseDate,
    this.genres,
    this.id,
    this.title,
    this.backdropPath,
    this.overview,
  });

  DetailsModel.fromJson(Map<String, dynamic> json) {
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    genres = (json['genres'] as List<dynamic>).map((value) => GenreModel.fromJson(value)).toList();
    id = json['id'] ?? 0;
    title = json['title'];
    backdropPath = json['backdrop_path'];
    overview = json['overview'];
  }
}
