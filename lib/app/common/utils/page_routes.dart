import 'package:flutter/material.dart';
import 'package:upcoming_movies/app/modules/details/details_module.dart';
import 'package:upcoming_movies/app/modules/home/home_module.dart';

class PageRoutes {
  static const String homeRoute = '/home';
  static const String detailsRoute = '/details';

  static String lastPage;

  static Route routes(RouteSettings settings) {
    Map<String, dynamic> argumentsMap = settings.arguments is Map<String, dynamic> ? settings.arguments : Map();

    switch (settings.name) {
      case PageRoutes.detailsRoute:
        return MaterialPageRoute(builder: (_) => DetailsModule(movieId: argumentsMap['movieId']));
      case PageRoutes.homeRoute:
      default:
        return MaterialPageRoute(builder: (_) => HomeModule());
    }
  }
}
