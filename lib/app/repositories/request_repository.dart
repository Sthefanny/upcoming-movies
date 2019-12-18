import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:upcoming_movies/app/common/models/enums/messages_enum.dart';
import 'package:upcoming_movies/app/configs/urls_config.dart';

class RequestRepository extends Disposable {
  Dio _client;
  UrlsConfig _urls;

  RequestRepository({@required UrlsConfig urlsConfig}) : assert(urlsConfig != null) {
    _urls = urlsConfig;
    setClient();
  }

  setClient() {
    _client = Dio(BaseOptions(baseUrl: _urls.baseUrl));
  }

  Future<dynamic> doGet({String urlPart, Map<String, dynamic> queryParameters}) async {
    Response response;
    try {
      if (!await checkInternet()) {
        throw new Exception(MessagesEnumDescription[MessagesEnum.NO_INTERNET_EXCEPTION]);
      }
      response = await _client.get(
        urlPart,
        queryParameters: queryParameters,
      );
    } on TimeoutException catch (_) {
      throw new Exception(MessagesEnumDescription[MessagesEnum.TIMEOUT_EXCEPTION]);
    } on NoSuchMethodError catch (_) {
      throw new Exception(MessagesEnumDescription[MessagesEnum.GENERAL_EXCEPTION]);
    } on DioError catch (e) {
      throw new Exception(e.error != null ? e.error : MessagesEnumDescription[MessagesEnum.GENERAL_EXCEPTION]);
    } catch (e) {
      throw new Exception(e.message != null ? e.message : MessagesEnumDescription[MessagesEnum.GENERAL_EXCEPTION]);
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    }

    throw new Exception(MessagesEnumDescription[MessagesEnum.GENERAL_EXCEPTION]);
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    return connectivityResult != ConnectivityResult.none;
  }

  @override
  void dispose() {}
}
