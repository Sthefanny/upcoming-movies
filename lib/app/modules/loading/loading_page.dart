import 'package:flutter/material.dart';

import '../../app_module.dart';
import 'loading_bloc.dart';

class LoadingPage extends StatelessWidget {
  final _loadingBloc = AppModule.to.getBloc<LoadingBloc>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _loadingBloc.loadingVisibility,
      builder: (context, snapshot) {
        return buildLoading(context, snapshot.data ?? false);
      },
    );
  }

  Widget buildLoading(BuildContext context, [bool visible = true]) {
    return Visibility(
      visible: visible,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(0, 0, 0, 0.5),
        child: Center(
          child: Card(
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text('Carregando...'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
