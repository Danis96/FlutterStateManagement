import 'package:flutter/material.dart';
import 'package:kpi_get_it/app/utils/navigation_animation.dart';
import 'package:kpi_get_it/app/view/artist_details/page/artist_details_page.dart';
import 'package:kpi_get_it/routing/routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ArtistDetails:
        return SlideAnimationTween(
          widget: ArtistDetailPage(),
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
