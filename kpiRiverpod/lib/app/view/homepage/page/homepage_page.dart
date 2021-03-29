import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kpiRiverpod/app/models/artist_model.dart';
import 'package:kpiRiverpod/app/state_notifiers/artist_state_notifier.dart';
import 'package:kpiRiverpod/app/utils/navigation_animation.dart';
import 'package:kpiRiverpod/app/view/artist_details/page/artist_details_page.dart';
import 'package:kpiRiverpod/app/view/homepage/widgets/homepage_app_bar.dart';
import 'package:kpiRiverpod/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:kpiRiverpod/app/view/homepage/widgets/homepage_headline.dart';

final StateNotifierProvider<ArtistStateNotifier> artistProvider =
    StateNotifierProvider<ArtistStateNotifier>(
  (ProviderReference ref) => ArtistStateNotifier(
    <ArtistModel>[],
  ),
);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read(artistProvider).getArtists();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context,
        T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
      final List<ArtistModel> artists = watch(artistProvider.state);

      return Scaffold(
        appBar: homeAppBar(
          title: 'Artist App',
          context: context,
        ),
        body: artists.isEmpty
            ? const SpinKitCircle(
                color: Colors.deepPurple,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: homePageHeadline(
                        title: 'Welcome to Artist App',
                        subtitle: 'State Management with Riverpod',
                        context: context,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: artists.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        final ArtistModel singleArtist = artists[index];

                        return GestureDetector(
                            onTap: () => Navigator.of(context).push<dynamic>(
                                  SlideAnimationTween(
                                    widget: ArtistDetailPage(
                                      albumUrl: singleArtist.aAlbum,
                                      artistModel: singleArtist,
                                    ),
                                  ),
                                ),
                            child: artistCard(
                              image: singleArtist.aImage,
                              name: singleArtist.aName,
                              description: singleArtist.aDescription,
                              context: context,
                            ));
                      },
                    ),
                  ],
                ),
              ),
      );
    });
  }
}
