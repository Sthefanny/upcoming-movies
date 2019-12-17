import 'package:upcoming_movies/app/modules/details/details_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:upcoming_movies/app/modules/details/details_page.dart';
import 'package:upcoming_movies/app/repositories/movie_details_repository.dart';

import '../../app_module.dart';

export 'package:upcoming_movies/app/repositories/movie_details_repository.dart';
export 'package:upcoming_movies/app/modules/details/details_bloc.dart';

class DetailsModule extends ModuleWidget {
  final int movieId;

  DetailsModule({@required this.movieId});

  @override
  List<Bloc> get blocs => [
        Bloc((i) => DetailsBloc(movieId: movieId, movieDetailsRepository: to.getDependency())),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => MovieDetailsRepository(urlsConfig: AppModule.to.getDependency(), requestRepository: AppModule.to.getDependency())),
      ];

  @override
  Widget get view => DetailsPage();

  static Inject get to => Inject<DetailsModule>.of();
}
