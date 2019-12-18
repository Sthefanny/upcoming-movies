import 'package:flutter/material.dart';

import 'common/utils/page_routes.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upcoming Movies',
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.grey[900],
          accentColor: Colors.grey,
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.grey[300]),
          )),
      onGenerateRoute: PageRoutes.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
