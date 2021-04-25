import 'package:flutter/material.dart';
import 'package:kpiProvider/app/providers/artist_provider.dart';
import 'package:kpiProvider/app/utils/navigation_animation.dart';
import 'package:kpiProvider/app/view/artist_details/page/artist_details_page.dart';
import 'package:kpiProvider/routing/routes.dart';
import 'package:provider/provider.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case ArtistDetails:
        return SlideAnimationTween(
          widget: ChangeNotifierProvider<ArtistProvider>.value(
            value: settings.arguments as ArtistProvider,
            child: ArtistDetailsChild(),
          ),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<void>(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Container(
            child: const Text('Error Screen'),
          ),
        ),
      );
    });
  }
}
