import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/foundation.dart';
import 'package:upcoming_movies/app/common/models/details_model.dart';
import 'package:upcoming_movies/app/repositories/movie_details_repository.dart';

class DetailsBloc extends BlocBase {
  MovieDetailsRepository _repository;
  int _movieId;

  DetailsBloc({@required MovieDetailsRepository movieDetailsRepository, @required int movieId}) : assert(movieDetailsRepository != null && movieId != null) {
    _repository = movieDetailsRepository;
    _movieId = movieId;
  }

  Future<DetailsModel> getUpcomingMovies() async {
    String error;
    DetailsModel movieDetails;

    try {
      var response;
      response = await _repository.getDetails(_movieId);

      movieDetails = DetailsModel.fromJson(response);
    } catch (e) {
      error = e.message;
    }
    if (error != null && error != '') throw (error);

    return movieDetails;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
