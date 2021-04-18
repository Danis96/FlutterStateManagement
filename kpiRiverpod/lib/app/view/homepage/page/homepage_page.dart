import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kpiRiverpod/app/models/artist_model.dart';
import 'package:kpiRiverpod/app/state_notifiers/artist_state_notifier.dart';
import 'package:kpiRiverpod/app/view/artist_details/page/artist_details_page.dart';
import 'package:kpiRiverpod/app/view/homepage/widgets/homepage_app_bar.dart';
import 'package:kpiRiverpod/app/view/homepage/widgets/homepage_artist_card.dart';
import 'package:kpiRiverpod/app/view/homepage/widgets/homepage_headline.dart';
import 'package:kpiRiverpod/routing/routes.dart';

// registering riverpod
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
    context.read(artistProvider).fetchArtistInInit(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(title: 'Artist App', context: context),
      body: _buildListBody(context),
    );
  }
}

Widget _buildListBody(BuildContext context) {
  return ListView(
    padding: const EdgeInsets.symmetric(horizontal: 24.0),
    children: <Widget>[
      Container(
        margin: const EdgeInsets.only(top: 30),
        child: homePageHeadline(
          title: 'Welcome to Artist App',
          subtitle: 'State Management with Riverpod',
          context: context,
        ),
      ),
      const SizedBox(height: 25),
      _buildArtistList(),
    ],
  );
}

Widget _buildArtistList() {
  return Consumer(builder: (BuildContext context,
      T Function<T>(ProviderBase<Object, T>) watch, Widget child) {
    final List<ArtistModel> artists = watch(artistProvider.state);
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: artists.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        final ArtistModel singleArtist = artists[index];
        return GestureDetector(
          onTap: () {
            watch(artistProvider).setArtistModel(singleArtist);
            watch(albumProvider).setAlbumUrl(singleArtist.aAlbum);
            Navigator.of(context).pushNamed(ArtistDetails);
          },
          child: artistCard(
            image: singleArtist.aImage,
            name: singleArtist.aName,
            description: singleArtist.aDescription,
            context: context,
          ),
        );
      },
    );
  });
}
