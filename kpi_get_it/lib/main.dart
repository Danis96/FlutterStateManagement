import 'package:flutter/material.dart';
import 'package:kpi_get_it/app/get_it/locator.dart';
import 'package:kpi_get_it/routing/route_generator.dart';
import 'app/view/homepage/page/homepage_page.dart';
import 'theme/config.dart';
import 'theme/custom_theme.dart';

void main() {
  setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artist app',
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      themeMode: currentTheme.currentTheme,
      home: Home(),
    );
  }
}
