import 'package:flutter/material.dart';
import 'package:upcoming_movies/app/common/models/results_model.dart';
import 'package:upcoming_movies/app/common/utils/snackbar_messages.dart';
import 'package:upcoming_movies/app/modules/home/home_module.dart';
import 'package:upcoming_movies/app/modules/home/widgets/movies_list.dart';

class SearchPage extends SearchDelegate<String> {
  final HomeBloc _bloc = HomeModule.to.getBloc();
  List<ResultModel> items;

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith();
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty)
      return Container();
    else
      return loadList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty || query.length < 3)
      return Container();
    else
      return loadList();
  }

  Widget loadList() {
    return FutureBuilder<List>(
        future: _bloc.loadSuggestions(query),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasError) SnackbarMessages.buildErrorMessage(context, snapshot.error.toString());
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return InkWell(
                    child: MoviesList(item: snapshot.data[index]),
                    onTap: () {
                      close(context, snapshot.data[index].trackableObjectId.toString());
                    },
                  );
                },
                itemCount: snapshot.data.length,
              ),
            );
          }
        });
  }
}
