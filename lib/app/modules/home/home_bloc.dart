import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:upcoming_movies/app/common/models/genre_model.dart';
import 'package:upcoming_movies/app/common/models/movies_model.dart';
import 'package:upcoming_movies/app/common/models/results_model.dart';
import 'package:upcoming_movies/app/repositories/movies_repository.dart';

class HomeBloc extends BlocBase {
  MoviesRepository _repository;
  final _resultModelController = BehaviorSubject<List<ResultModel>>.seeded(List<ResultModel>());

  HomeBloc({@required MoviesRepository moviesRepository}) : assert(moviesRepository != null) {
    _repository = moviesRepository;
  }

  Stream<List<ResultModel>> get resultModel => _resultModelController.stream;

  Function(List<ResultModel>) get addResulModel => _resultModelController.sink.add;

  Future<List<GenreModel>> getAllGenres() async {
    String error;
    GenresModel genres;

    try {
      var response;
      response = await _repository.getAllGenres();

      genres = GenresModel.fromJson(response);
    } catch (e) {
      error = e.message;
    }
    if (error != null && error != '') throw (error);

    return genres.genres;
  }

  Future<MoviesModel> getUpcomingMovies([int page = 1]) async {
    String error;
    MoviesModel movies;

    try {
      var response;
      response = await _repository.getUpcomingMovies(page);
      var genres = await getAllGenres();

      movies = MoviesModel.fromJson(response, genres);
    } catch (e) {
      error = e.message;
    }
    if (error != null && error != '') throw (error);

    return movies;
  }

  Future<List<ResultModel>> loadSuggestions(String search) async {
    String error;
    List<ResultModel> details;

    try {
      var response = await _repository.moviesSearch(search);
      var genres = await getAllGenres();

      details = MoviesModel.fromJson(response, genres).results;
    } catch (e) {
      error = e.message;
    }
    if (error != null && error != '') throw (error);

    return details;
  }

  @override
  void dispose() {
    _resultModelController.close();
    super.dispose();
  }
}
