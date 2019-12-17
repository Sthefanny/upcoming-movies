import 'package:upcoming_movies/app/app_module.dart';
import 'package:upcoming_movies/app/modules/home/home_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:upcoming_movies/app/modules/home/home_page.dart';
import 'package:upcoming_movies/app/repositories/movies_repository.dart';

export 'package:upcoming_movies/app/modules/search/search_bloc.dart';
export 'package:upcoming_movies/app/repositories/movies_repository.dart';
export 'package:upcoming_movies/app/modules/home/home_bloc.dart';

class HomeModule extends ModuleWidget {
  @override
  List<Bloc> get blocs => [
        Bloc((i) => HomeBloc(moviesRepository: to.getDependency())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => MoviesRepository(urlsConfig: AppModule.to.getDependency(), requestRepository: AppModule.to.getDependency())),
      ];

  @override
  Widget get view => HomePage();

  static Inject get to => Inject<HomeModule>.of();
}
