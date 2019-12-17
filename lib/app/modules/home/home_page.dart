import 'package:flutter/material.dart';
import 'package:upcoming_movies/app/app_module.dart';
import 'package:upcoming_movies/app/common/models/movies_model.dart';
import 'package:upcoming_movies/app/common/models/results_model.dart';
import 'package:upcoming_movies/app/modules/home/home_bloc.dart';
import 'package:upcoming_movies/app/modules/home/home_module.dart';
import 'package:upcoming_movies/app/modules/loading/loading_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBloc _bloc = HomeModule.to.getBloc();
  final UrlsConfig _urls = AppModule.to.getDependency();
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
    try {
      _movieModel = _bloc.getUpcomingMovies();
    } catch (e) {
      print('Error: $e');
    }
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
      ),
      body: Stack(
        children: <Widget>[
          buildList(),
          LoadingPage(),
        ],
      ),
    );
  }

  Widget buildList() {
    return FutureBuilder(
      future: _movieModel,
      builder: (context, AsyncSnapshot<MoviesModel> snapshot) {
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
                return buildCard(item: item);
              },
            );
          },
        );
      },
    );
  }

  Widget buildCard({ResultModel item}) {
    Widget image;
    if (item.posterPath != null || item.backdropPath != null)
      image = item.posterPath != null ? Image.network('${_urls.imageUrl}${item.posterPath}') : Image.network('${_urls.imageUrl}${item.backdropPath}');
    var size = MediaQuery.of(context).size;
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: size.height * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(width: size.width * 0.2, child: image),
            Container(
              width: size.width * 0.65,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(child: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(child: Text(item.genreList.join(', '))),
                  Container(child: Text('Release Date: ${item.releaseDate}')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
