import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/foundation.dart';
import 'package:upcoming_movies/app/common/models/enums/messages_enum.dart';
import 'package:upcoming_movies/app/configs/urls_config.dart';
import 'package:upcoming_movies/app/repositories/request_repository.dart';

class MoviesRepository extends Disposable {
  RequestRepository _repository;
  UrlsConfig _urls;

  MoviesRepository({@required RequestRepository requestRepository, @required UrlsConfig urlsConfig}) : assert(requestRepository != null && urlsConfig != null) {
    _repository = requestRepository;
    _urls = urlsConfig;
  }

  Future<dynamic> getUpcomingMovies([int page = 1]) async {
    try {
      var url = '${_urls.upcomingMoviesUrl}&page=$page';
      var response = await _repository.doGet(urlPart: url);
      return response.data;
    } on NoSuchMethodError catch (_) {
      throw new Exception(MessagesEnumDescription[MessagesEnum.GENERAL_EXCEPTION]);
    } catch (e) {
      throw new Exception(e.message != null ? e.message : MessagesEnumDescription[MessagesEnum.GENERAL_EXCEPTION]);
    }
  }

  Future<Map<String, dynamic>> getAllGenres() async {
    try {
      var response = await _repository.doGet(urlPart: _urls.allGenresUrl);
      return response.data;
    } on NoSuchMethodError catch (_) {
      throw new Exception(MessagesEnumDescription[MessagesEnum.GENERAL_EXCEPTION]);
    } catch (e) {
      throw new Exception(e.message != null ? e.message : MessagesEnumDescription[MessagesEnum.GENERAL_EXCEPTION]);
    }
  }

  Future<dynamic> moviesSearch(String query) async {
    try {
      var url = '${_urls.searchMovieUrl}&query=$query';
      var response = await _repository.doGet(urlPart: url);
      return response.data;
    } on NoSuchMethodError catch (_) {
      throw new Exception(MessagesEnumDescription[MessagesEnum.GENERAL_EXCEPTION]);
    } catch (e) {
      throw new Exception(e.message != null ? e.message : MessagesEnumDescription[MessagesEnum.GENERAL_EXCEPTION]);
    }
  }

  @override
  void dispose() {}
}
