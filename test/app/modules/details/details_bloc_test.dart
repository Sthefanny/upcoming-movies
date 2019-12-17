import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:upcoming_movies/app/modules/details/details_bloc.dart';
import 'package:upcoming_movies/app/modules/details/details_module.dart';

void main() {
  initModule(DetailsModule());
  DetailsBloc bloc;

  setUp(() {
    bloc = DetailsModule.to.bloc<DetailsBloc>();
  });

  group('DetailsBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<DetailsBloc>());
    });
  });
}
