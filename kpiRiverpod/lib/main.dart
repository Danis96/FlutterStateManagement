import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/view/homepage/page/homepage_page.dart';
import 'theme/config.dart';
import 'theme/custom_theme.dart';

void main() => runApp(ProviderScope(child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Artist app',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.lightTheme,
      themeMode: currentTheme.currentTheme,
      home: HomePage(),
    );
  }
}