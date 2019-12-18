import 'package:upcoming_movies/app/common/models/results_model.dart';

import 'genre_model.dart';

class MoviesModel {
  final int page;
  final List<ResultModel> results;
  final int totalPages;
  final int totalResults;

  MoviesModel({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  MoviesModel.fromJson(Map<String, dynamic> json, List<GenreModel> genres)
      : page = json['page'] ?? 0,
        results = (json['results'] as List<dynamic>).map((value) => ResultModel.fromJson(value, genres)).toList(),
        totalPages = json['total_pages'] ?? 0,
        totalResults = json['total_results'] ?? 0;
}
