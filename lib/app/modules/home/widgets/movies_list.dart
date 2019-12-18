import 'package:flutter/material.dart';
import 'package:upcoming_movies/app/common/models/results_model.dart';
import 'package:upcoming_movies/app/common/utils/page_routes.dart';

import '../../../app_module.dart';

class MoviesList extends StatelessWidget {
  final ResultModel item;
  final UrlsConfig _urls = AppModule.to.getDependency();

  MoviesList({Key key, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget image;
    if (item.posterPath != null || item.backdropPath != null)
      image = item.posterPath != null ? Image.network('${_urls.imageUrl}${item.posterPath}') : Image.network('${_urls.imageUrl}${item.backdropPath}');
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(PageRoutes.detailsRoute, arguments: {'movieId': item.id}),
      child: Card(
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
      ),
    );
  }
}
