class GenresModel {
  final List<GenreModel> genres;

  GenresModel({
    this.genres,
  });

  GenresModel.fromJson(Map<String, dynamic> json) : genres = (json['genres'] as List<dynamic>).map((value) => GenreModel.fromJson(value)).toList();
}

class GenreModel {
  final int id;
  final String name;

  GenreModel({
    this.id,
    this.name,
  });

  GenreModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'];
}
