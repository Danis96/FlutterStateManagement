import 'package:flutter/material.dart';
import 'package:kpiRiverpod/app/utils/navigation_animation.dart';
import 'package:kpiRiverpod/app/view/artist_details/page/artist_details_page.dart';
import 'package:kpiRiverpod/routing/routes.dart';

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
