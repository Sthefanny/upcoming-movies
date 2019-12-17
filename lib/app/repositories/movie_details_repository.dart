import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/foundation.dart';
import 'package:upcoming_movies/app/common/models/enums/messages_enum.dart';
import 'package:upcoming_movies/app/configs/urls_config.dart';
import 'package:upcoming_movies/app/repositories/request_repository.dart';

class MovieDetailsRepository extends Disposable {
  RequestRepository _repository;
  UrlsConfig _urls;

  MovieDetailsRepository({@required RequestRepository requestRepository, @required UrlsConfig urlsConfig}) : assert(requestRepository != null && urlsConfig != null) {
    _repository = requestRepository;
    _urls = urlsConfig;
  }

  Future<dynamic> getDetails(int movieId) async {
    try {
      var url = '${_urls.movieDetailsUrl}/$movieId${UrlsConfig.apiKey}';
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
