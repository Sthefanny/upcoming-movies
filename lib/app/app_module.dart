import 'package:upcoming_movies/app/app_bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:upcoming_movies/app/app_widget.dart';

import 'configs/urls_config.dart';
import 'modules/loading/loading_bloc.dart';
import 'repositories/request_repository.dart';

export 'configs/urls_config.dart';
export 'modules/loading/loading_bloc.dart';
export 'repositories/request_repository.dart';

class AppModule extends ModuleWidget {
  final urlsConfig = UrlsConfig();

  @override
  List<Bloc> get blocs => [
        Bloc((i) => AppBloc()),
        Bloc((i) => LoadingBloc()),
      ];

  @override
  List<Dependency> get dependencies => [
        Dependency((i) => RequestRepository(urlsConfig: to.getDependency())),
        Dependency((i) => urlsConfig),
      ];

  @override
  Widget get view => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
