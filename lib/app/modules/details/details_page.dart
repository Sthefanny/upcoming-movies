import 'package:flutter/material.dart';
import 'package:upcoming_movies/app/common/models/details_model.dart';
import 'package:upcoming_movies/app/common/utils/snackbar_messages.dart';

import '../../app_module.dart';
import 'details_module.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsBloc _bloc = DetailsModule.to.getBloc();
  final UrlsConfig _urls = AppModule.to.getDependency();
  Future<DetailsModel> _item;
  Size _size;

  @override
  void initState() {
    _item = _bloc.getUpcomingMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: buildBody(),
      ),
    );
  }

  Widget buildBody() {
    return FutureBuilder(
      future: _item,
      builder: (context, AsyncSnapshot<DetailsModel> snapshot) {
        if (snapshot.hasError) {
          SnackbarMessages.buildErrorMessage(context, snapshot.error);
          return Container();
        }

        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        var item = snapshot.data;

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[700],
                    offset: Offset(0.0, 1.5),
                    blurRadius: 1.5,
                  ),
                ]),
                height: _size.height * 0.5,
                child: item.posterPath != null ? Image.network('${_urls.imageUrl}${item.posterPath}') : null,
              ),
              Container(padding: EdgeInsets.symmetric(vertical: 10), child: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
              Container(padding: EdgeInsets.only(bottom: 10), child: Text(item.genres.map((g) => g.name).join(', '))),
              Container(padding: EdgeInsets.symmetric(vertical: 10), child: Text(item.overview, textAlign: TextAlign.justify)),
              Container(padding: EdgeInsets.symmetric(vertical: 10), child: Text('Release Date: ${item.releaseDate}')),
            ],
          ),
        );
      },
    );
  }
}
