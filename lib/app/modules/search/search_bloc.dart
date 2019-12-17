// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:upcoming_movies/app/common/models/results_model.dart';
// import 'package:upcoming_movies/app/modules/home/home_module.dart';

// class SearchBloc extends BlocBase {
//   final MoviesRepository _lastPositionsRepository = HomeModule.to.getDependency();

//   Future<List<ResultModel>> loadSuggestions(String search) async {
//     ResultModel details;

//     try {
//       var response = await _lastPositionsRepository.moviesSearch(search);
//       details = ResultModel.fromJson(json, genres)
//       return response.data;
//     } catch (e) {
//       throw Exception(e.message != null ?? 'Erro');
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
