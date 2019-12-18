import 'package:flutter/material.dart';
import 'package:upcoming_movies/app/app_module.dart';
import 'package:upcoming_movies/app/common/models/movies_model.dart';
import 'package:upcoming_movies/app/common/models/results_model.dart';
import 'package:upcoming_movies/app/common/utils/page_routes.dart';
import 'package:upcoming_movies/app/common/utils/snackbar_messages.dart';
import 'package:upcoming_movies/app/modules/home/home_bloc.dart';
import 'package:upcoming_movies/app/modules/home/home_module.dart';
import 'package:upcoming_movies/app/modules/loading/loading_page.dart';
import 'package:upcoming_movies/app/modules/search/search_page.dart';

import 'widgets/movies_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = HomeModule.to.getBloc();
  final LoadingBloc _loadingBloc = AppModule.to.getBloc();

  Future<MoviesModel> _movieModel;
  List<ResultModel> _movies;
  int _totalRecord = 0;
  int _totalPages = 0;
  int _actualPage = 1;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _loadingBloc.changeVisibility(false);
    _movieModel = _bloc.getUpcomingMovies();
    _scrollController = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  _scrollListener() {
    if (_totalRecord == _movies.length) {
      return;
    }
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      _loadNextItems();
    }
    if (_scrollController.position.pixels == _scrollController.position.minScrollExtent) {
      _loadPrevItems();
    }
  }

  _loadNextItems() {
    _loadingBloc.changeVisibility(true);
    if (_actualPage < _totalPages) {
      _bloc.addResulModel(null);
      _actualPage++;
      _bloc.getUpcomingMovies(_actualPage).then((data) {
        _loadingBloc.changeVisibility(false);
        _bloc.addResulModel(data.results);
      });
    } else
      _loadingBloc.changeVisibility(false);
  }

  _loadPrevItems() {
    _loadingBloc.changeVisibility(true);
    if (_actualPage > 1) {
      _bloc.addResulModel(null);
      _actualPage--;
      _bloc.getUpcomingMovies(_actualPage).then((data) {
        _loadingBloc.changeVisibility(false);
        _bloc.addResulModel(data.results);
      });
    } else
      _loadingBloc.changeVisibility(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upcoming Movies'),
        actions: <Widget>[buildSearchField()],
      ),
      body: Stack(
        children: <Widget>[
          Padding(padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10), child: buildList()),
          LoadingPage(),
        ],
      ),
    );
  }

  Widget buildSearchField() {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Icon(Icons.search),
      ),
      onTap: () async {
        String result = await showSearch(context: context, delegate: SearchPage());
        if (result != null) {
          Navigator.of(context).pushNamed(PageRoutes.detailsRoute, arguments: {'movieId': result});
        }
      },
    );
  }

  Widget buildList() {
    return FutureBuilder(
      future: _movieModel,
      builder: (context, AsyncSnapshot<MoviesModel> snapshot) {
        if (snapshot.hasError) {
          SnackbarMessages.buildErrorMessage(context, snapshot.error);
          return Container();
        }

        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        _movies = snapshot.data.results;
        _totalRecord = snapshot.data.totalResults;
        _totalPages = snapshot.data.totalPages;

        _bloc.addResulModel(_movies);

        return StreamBuilder(
          stream: _bloc.resultModel,
          builder: (context, AsyncSnapshot<List<ResultModel>> snap) {
            if (!snap.hasData) return Center(child: CircularProgressIndicator());
            _movies = snap.data;

            return ListView.builder(
              controller: _scrollController,
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                var item = _movies[index];
                return MoviesList(item: item);
              },
            );
          },
        );
      },
    );
  }
}
