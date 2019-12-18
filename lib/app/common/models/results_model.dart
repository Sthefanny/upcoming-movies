import 'genre_model.dart';

class ResultModel {
  String posterPath;
  String releaseDate;
  List<dynamic> genreIds;
  List<String> genreList;
  int id;
  String title;
  String backdropPath;

  ResultModel({
    this.posterPath,
    this.releaseDate,
    this.genreIds,
    this.genreList,
    this.id,
    this.title,
    this.backdropPath,
  });

  ResultModel.fromJson(Map<String, dynamic> json, List<GenreModel> genres) {
    posterPath = json['poster_path'];
    releaseDate = json['release_date'];
    genreIds = json['genre_ids'];
    id = json['id'] ?? 0;
    title = json['title'];
    backdropPath = json['backdrop_path'];

    if (json['genre_ids'] != null) {
      genreList = List<String>();
      json['genre_ids'].forEach((v) {
        var a = genres.firstWhere((g) => g.id == v);
        genreList.add(a.name);
      });
    }
  }
}
